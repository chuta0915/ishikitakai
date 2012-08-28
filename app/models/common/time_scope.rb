module Common::TimeScope
  def self.included(base)
    base.class_eval do
      
      class_attribute :time_scope_field, :time_scope_table
      base.time_scope_field = :created_at
      
      scope :yesterday, lambda{|time = nil, field = nil|
        time = Time.current if time.blank?
        today(time - 1.day, field) }
      
      scope :today, lambda{|time = nil, field = nil|
        time = Time.current if time.blank?
        between(time, nil, field)}
      
      scope :daily, lambda{|time = nil, field = nil| today(time, field) }
      
      scope :weekly, lambda{|time = nil, field = nil| 
        time = Time.current if time.blank?
        between(time.beginning_of_week(:sunday), time.end_of_week(:sunday), field) }
      
      scope :monthly, lambda{|time = nil, field = nil|
        time = Time.current if time.blank?
        between(time.beginning_of_month, time.end_of_month, field) }
        
      scope :yearly, lambda{|time =nil, field =nil|
        time = Time.current if time.blank?
        between(time.beginning_of_year, time.end_of_year, field) }
      
      scope :between, lambda{|start_at = nil, end_at = nil, field = nil|
        start_at = Time.current if start_at.blank?
        end_at = start_at if end_at.blank?
        table_name = base.table_name.present? ? base.table_name : base.name.tableize
        field = "#{table_name}.#{base.time_scope_field}" if field.blank?
        attrs = field.to_s.split(".")
        raise if attrs[1].present? && table_name != attrs[0]
        raise unless base.columns.map {|f| f.name}.include?(attrs[1].blank? ? field.to_s : attrs[1])

        where("#{field.to_s} >= ?", start_at.beginning_of_day)
          .where("#{field.to_s} < ?", (end_at + 1.day).beginning_of_day ) }
    end
  end
end


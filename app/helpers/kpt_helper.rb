module KptHelper
  def kpt_path parent, kpt
    send_kpt_path '', parent, kpt
  end

  def kpts_path parent
    send("#{parent.class.to_s.downcase}_kpts_path".to_sym, parent)
  end

  private
  def send_kpt_path kind, parent, kpt
    kind = "#{kind}_" if kind.present?
    send("#{kind}#{parent.class.to_s.downcase}_kpt_path".to_sym, parent, kpt)
  end
end


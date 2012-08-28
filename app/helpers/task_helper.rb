module TaskHelper
  def task_path parent, task
    send_task_path '', parent, task
  end

  def tasks_path parent
    send("#{parent.class.to_s.downcase}_tasks_path".to_sym, parent)
  end

  private
  def send_task_path kind, parent, task
    kind = "#{kind}_" if kind.present?
    send("#{kind}#{parent.class.to_s.downcase}_task_path".to_sym, parent, task)
  end
end

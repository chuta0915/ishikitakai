module WikiHelper
  def edit_wiki_path parent, wiki
    send_wiki_path 'edit', parent, wiki
  end

  def new_wiki_path parent
    send("new_#{parent.class.to_s.downcase}_wiki_path".to_sym, parent)
  end

  def wiki_path parent, wiki
    send_wiki_path '', parent, wiki
  end

  private
  def send_wiki_path kind, parent, wiki
    kind = "#{kind}_" if kind.present?
    send("#{kind}#{parent.class.to_s.downcase}_wiki_path".to_sym, parent, wiki)
  end
end

module OnceAssignedEverWatcher
  class Hooks < Redmine::Hook::ViewListener
    def controller_issues_edit_before_save (context={})
      if context[:issue] && context[:issue].id != nil                      
        issue = Issue.find_by_id(context[:issue].id)      
        if issue.assigned_to_id != nil
          Watcher.where(watchable_type: "Issue", watchable_id: context[:issue].id, user_id: issue.assigned_to_id).first_or_create
        end
      end
    end
  end
end

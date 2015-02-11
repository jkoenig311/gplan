module Printer
  def print stories
    end_of_pbs = false
    release_notes = "ID:STATUS:TITLE:PROJECT_NAME:PROJECT_ALIAS:PR:TITLE\n"
    dependencies = []
    stories.each do |story|
      if !end_of_pbs and story['name'].nil?
        end_of_pbs = true
        release_notes += title "Unmatched PRs"
        release_notes += "PR:TITLE\n"
      end

      dependency = pull_dependency(story)
      dependencies << dependency unless dependency.nil?

      line = ""
      line += planbox_info story unless end_of_pbs
      line += github_pr_info story unless story['number'].nil?

      release_notes += line + "\n"
    end

    # print dependency blocks
    unless dependencies.empty?
      release_notes += include_dependencies dependencies
    end

    puts release_notes
  end

  def planbox_info story
    "#{story['id']}:#{story['status']}:#{story['name']}:#{story['project_name']}:#{story['project_alias']}"
  end

  def github_pr_info story
    line = ":#{story['number']}:#{story['title']}"
    line += github_issue_info story if story['linked_issues']
    line
  end

  def github_issue_info story
    line = ""
    story['linked_issues'].each do |issue|
      line += ":ISSUE##{issue['number']}"
      line +=":Milestone #{issue['milestone']['title']}" if issue['milestone']['title']
    end
    line
  end

  def include_dependencies dependencies
      release_notes = title "Dependencies"
      dependencies.each do |dependency|
        release_notes += dependency
        release_notes += "\n"
      end
      release_notes
  end

  def title text
    "\n---- #{text} ----\n\n"
  end
end

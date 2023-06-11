class Download < ActiveRecord::Base
  def download
    @time_started = 0
    @time_finished = 0
    @num_files = 0
    @user = ''
    @num_issues = 0
    @project = ''
    @messages = ''
    @result = 1
  end
end

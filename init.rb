Redmine::Plugin.register :downloader do
  name 'Issue\'s attachments downloader plugin'
  author 'Benoît Clouet'
  description 'This plugin allows download of all attachments of the issues of a project'
  version '0.0.1'
  url 'https://github.com/clouetb/downloader'
  author_url 'https://github.com/clouetb'
  # caption = I18n.t 'label_download_menu'
  permission :downloads, { downloads: [:index, :download] }, public: false
  menu :project_menu, :downloads, {controller: 'downloads', action: 'index'}, caption: 'Download', after: :issues, param: :project_id
  settings :default => { 'attachments_limit' => 10 }, :partial => 'settings/attachments_limit'
end

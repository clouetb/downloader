Redmine::Plugin.register :downloader do
  name 'Downloader plugin'
  author 'Benoît Clouet'
  description 'This plugin allows download of all attachments of the issues of a project'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  # caption = I18n.t 'label_download_menu'
  permission :downloads, { downloads: [:index, :download] }, public: true
  menu :project_menu, :downloads, {controller: 'downloads', action: 'index'}, caption: 'Download', after: :activity, param: :project_id
  settings :default => { 'attachments_limit' => 10 }, :partial => 'settings/attachments_limit'
end

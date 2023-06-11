class DownloadsController < ApplicationController

  # helper :sort
  # include SortHelper
  # helper :queries
  # include QueriesHelper
  # helper :download_query
  # include DownloadQuery

  def index
    @project = Project.find(params[:project_id])
    @downloads = Download.all
  end

  def download
    @project = Project.find(params[:project_id])
    current_download = Download.create(time_started: Time.now, user: find_current_user, project: @project)
    number_of_issues = 0
    number_of_files = 0
    download_result = 1
    zipname = "#{params[:project_id]}_#{Time.now.strftime("%Y-%m-%d_%Hh%Mm%Ss")}.zip"
    disposition = ActionDispatch::Http::ContentDisposition.format(disposition: "attachment", filename: zipname)

    response.headers["Content-Disposition"] = disposition
    response.headers["Content-Type"] = "application/zip"
    response.headers.delete("Content-Length")
    response.headers["Cache-Control"] = "no-cache"
    response.headers["Last-Modified"] = Time.now.httpdate.to_s
    response.headers["X-Accel-Buffering"] = "no"

    writer = ZipTricks::BlockWrite.new do |chunk|
      response.stream.write(chunk)
    end

    ZipTricks::Streamer.open(writer, auto_rename_duplicate_filenames: true) do |zip|
      @project.issues.find_each do |issue|
        number_of_issues = number_of_issues + 1
        issue.attachments.find_each do |attachment|
          number_of_files = number_of_files + 1
          filename_inside_zip = "%04d/%s" % [issue.id, attachment.filename]
          filename_on_server = "%s/%s/%s" % [attachment.storage_path, attachment.disk_directory, attachment.disk_filename]
          zip.write_stored_file(filename_inside_zip) do |sink|
            File.open(filename_on_server, 'rb'){|source| IO.copy_stream(source, sink) }
          end
          # attachment.filename
          # attachment.disk_filename
          # attachment.filesize
          # attachment.storage_path
        end
      end
    end
    download_result = 0
  ensure
    current_download.time_finished = Time.now
    current_download.num_files = number_of_files
    current_download.num_issues = number_of_issues
    current_download.result = download_result
    current_download.save
    response.stream.close
  end
end

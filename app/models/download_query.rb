
module DownloadQueryHelper
  class DownloadQuery < Query
    self.queried_class = Download

    self.available_columns = [
      QueryColumn.new(:project, sortable: "#{Download.table_name}.project"),
      QueryColumn.new(:user, sortable: "#{Download.table_name}.user"),
      QueryColumn.new(:time_started, sortable: "#{Download.table_name}.time_started"),
      QueryColumn.new(:time_finished, sortable: "#{Download.table_name}.time_finished"),
      QueryColumn.new(:num_issues, sortable: "#{Download.table_name}.num_issues"),
      QueryColumn.new(:num_files, sortable: "#{Download.table_name}.num_files"),
      QueryColumn.new(:messages, sortable: "#{Download.table_name}.messages"),
      QueryColumn.new(:result, sortable: "#{Download.table_name}.result"),
    ]

    def initialize_available_filters
      add_available_filter "project", type: :string
      add_available_filter "user", type: :string
      add_available_filter "time_started", type: :date_past
      add_available_filter "time_finished", type: :date_past
      add_available_filter "num_issues", type: :integer
      add_available_filter "num_files", type: :integer
      add_available_filter "messages", type: :string
      add_available_filter "result", type: :integer
    end

    def available_columns
      return @available_columns if @available_columns
      return self.class.available_columns.dup
    end

    def default_columns_names
      @default_columns_names ||= [:project, :user, :time_started, :time_finished, :num_issues, :num_files, :messages, :result]
    end

    def default_sort_criteria
      [['time_started', 'asc']]
    end

  end
end
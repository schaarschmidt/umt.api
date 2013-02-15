# It is recommended to set time zone in TZ environment variable so that the same timezone will be used by Ruby and by Oracle session
ENV['TZ'] = 'UTC'

ActiveSupport.on_load(:active_record) do
  ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
    # id columns and columns which end with _id will always be converted to integers
    self.emulate_integers_by_column_name = true
    # DATE columns which include "date" in name will be converted to Date, otherwise to Time
    self.emulate_dates_by_column_name = true
    # true and false will be stored as 'Y' and 'N'
    self.emulate_booleans_from_strings = true
    # start primary key sequences from 1 (and not 10000) and take just one next value in each session
    self.default_sequence_start_value = "1 NOCACHE INCREMENT BY 1"
    # other settings ...
  end
end

plsql.activerecord_class = ActiveRecord::Base

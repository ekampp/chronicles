module ApplicationHelper

  # This will calculate the class of the progress bar based on some common
  # delimiters.
  #
  def progress_class progress
    klass = "progress-danger"
    progress = progress.to_i
    klass = "progress-warning" if progress > 30
    klass = "progress-info" if progress > 60
    klass = "progress-success" if progress > 90
    klass
  end

end

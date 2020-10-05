# frozen_string_literal: true

require 'rake'

shared_context 'rake' do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { get_task_name_from_description(self.class) }
  let(:task_path) { "lib/tasks/#{task_name.split(':').first}" }
  subject         { rake[task_name] }

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path, [Rails.root.to_s], loaded_files_excluding_current_rake_file)

    Rake::Task.define_task(:environment)
  end

  private

  def loaded_files_excluding_current_rake_file
    $".reject { |file| file == Rails.root.join("#{task_path}.rake").to_s }
  end

  def get_task_name_from_description(klass)
    while klass != Object
      if klass.respond_to? :description
        # search for description in form of 'abc:def'
        return klass.description if klass.description =~ /^\S+:\S+$/
      end
      klass = klass.parent
    end
    raise 'cannot determine rake task name'
  end
end

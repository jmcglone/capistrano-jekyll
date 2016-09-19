load File.expand_path("../set_rails_env.rake", __FILE__)

desc 'Jekyll integration'
namespace :jekyll do
  desc 'Build the website using Jekyll'
  task :build => [:set_rails_env] do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :jekyll, 'build'
        end
      end
    end
  end

  desc 'Print Jekyll deprecation warnings'
  task :doctor => [:set_rails_env] do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :jekyll, 'doctor'
        end
      end
    end
  end

  after 'deploy:updated', 'jekyll:build'
end

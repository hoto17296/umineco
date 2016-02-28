namespace :assets do

  desc 'Build assets on webpack'
  task :precompile do
    cd 'frontend' do
      sh 'npm install'
      sh 'npm run build'
    end
  end

end

# Standalone recipe installs the sys schema. This is not part of the default run
# or any other configuraiton. It must be specified in a role

package 'git' do
  action :install
end

execute 'schema' do
  user 'root'
  cwd '/tmp'
  command "git clone https://github.com/mysql/mysql-sys.git && mysql -u root -p #{node['mariadb']['server_root_password']} < mysql-sys/sys_56.sql"
  not_if { ::File.exist?("/tmp/mysql-sys/sys_56.sql") }
end

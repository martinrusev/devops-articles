#
# Cookbook Name:: apache2
# Attributes:: default
#
# Copyright 2008-2013, Chef Software, Inc.
# Copyright 2014, Viverae, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['apache']['mpm'] =
  case node['platform_family']
  when 'debian'
    case node['platform']
    when 'ubuntu'
      if node['platform_version'].to_f >= 14.04
        'event'
      elsif node['platform_version'].to_f >= 12.04
        'worker'
      else
        'prefork'
      end
    when 'debian'
      node['platform_version'].to_f >= 7.0 ? 'worker' : 'prefork'
    when 'linuxmint'
      node['platform_version'].to_i >= 17 ? 'event' : 'prefork'
    else
      'prefork'
    end
  else
    'prefork'
  end

default['apache']['version'] =
  case node['platform_family']
  when 'debian'
    case node['platform']
    when 'ubuntu'
      node['platform_version'].to_f >= 13.10 ? '2.4' : '2.2'
    when 'linuxmint'
      node['platform_version'].to_i >= 16 ? '2.4' : '2.2'
    when 'debian', 'raspbian'
      node['platform_version'].to_f >= 8.0 ? '2.4' : '2.2'
    else
      '2.4'
    end
  when 'rhel'
    case node['platform']
    when 'amazon'
      node['platform_version'].to_f >= 2013.09 ? '2.4' : '2.2'
    else
      node['platform_version'].to_f >= 7.0 ? '2.4' : '2.2'
    end
  when 'fedora'
    node['platform_version'].to_f >= 18 ? '2.4' : '2.2'
  when 'suse'
    case node['platform']
    when 'opensuse'
      node['platform_version'].to_f >= 13.1 ? '2.4' : '2.2'
      # FIXME: when "suse" for SLES
    else
      '2.4'
    end
  when 'freebsd'
    node['platform_version'].to_f >= 10.0 ? '2.4' : '2.2'
  else
    '2.4'
  end

default['apache']['root_group'] = 'root'
default['apache']['default_site_name'] = 'default'

# Where the various parts of apache are
case node['platform']
when 'redhat', 'centos', 'scientific', 'fedora', 'amazon', 'oracle'
  default['apache']['package']     = 'httpd'
  default['apache']['service_name'] = 'httpd'
  default['apache']['devel_package'] = 'httpd-devel'
  default['apache']['perl_pkg']    = 'perl'
  default['apache']['apachectl']   = '/usr/sbin/apachectl'
  default['apache']['dir']         = '/etc/httpd'
  default['apache']['log_dir']     = '/var/log/httpd'
  default['apache']['error_log']   = 'error.log'
  default['apache']['access_log']  = 'access.log'
  default['apache']['user']        = 'apache'
  default['apache']['group']       = 'apache'
  default['apache']['binary']      = '/usr/sbin/httpd'
  default['apache']['conf_dir']    = '/etc/httpd/conf'
  default['apache']['docroot_dir'] = '/var/www/html'
  default['apache']['cgibin_dir']  = '/var/www/cgi-bin'
  if node['apache']['version'] == '2.4'
    default['apache']['icondir'] = '/usr/share/httpd/icons'
  else
    default['apache']['icondir'] = '/var/www/icons'
  end
  default['apache']['cache_dir']   = '/var/cache/httpd'
  default['apache']['run_dir']     = '/var/run/httpd'
  default['apache']['lock_dir']    = '/var/run/httpd'
  if node['platform'] == 'amazon' && node['apache']['version'] == '2.4'
    default['apache']['package']     = 'httpd24'
    default['apache']['devel_package'] = 'httpd24-devel'
  end
  if node['platform_version'].to_f >= 6
    default['apache']['pid_file'] = '/var/run/httpd/httpd.pid'
  else
    default['apache']['pid_file'] = '/var/run/httpd.pid'
  end
  default['apache']['lib_dir']     = node['kernel']['machine'] =~ /^i[36]86$/ ? '/usr/lib/httpd' : '/usr/lib64/httpd'
  default['apache']['libexec_dir']  = "#{node['apache']['lib_dir']}/modules"
when 'suse', 'opensuse'
  default['apache']['package']     = 'apache2'
  default['apache']['perl_pkg']    = 'perl'
  default['apache']['devel_package'] = 'httpd-devel'
  default['apache']['apachectl']   = '/usr/sbin/apache2ctl'
  default['apache']['dir']         = '/etc/apache2'
  default['apache']['log_dir']     = '/var/log/apache2'
  default['apache']['error_log']   = 'error.log'
  default['apache']['access_log']  = 'access.log'
  default['apache']['user']        = 'wwwrun'
  default['apache']['group']       = 'www'
  default['apache']['binary']      = '/usr/sbin/httpd2'
  default['apache']['conf_dir']    = '/etc/apache2'
  default['apache']['docroot_dir'] = '/srv/www/htdocs'
  default['apache']['cgibin_dir']  = '/srv/www/cgi-bin'
  default['apache']['icondir']     = '/usr/share/apache2/icons'
  default['apache']['cache_dir']   = '/var/cache/apache2'
  default['apache']['run_dir']     = '/var/run/httpd'
  default['apache']['lock_dir']    = '/var/run/httpd'
  if node['platform_version'].to_f >= 6
    default['apache']['pid_file']    = '/var/run/httpd/httpd.pid'
  else
    default['apache']['pid_file']    = '/var/run/httpd.pid'
  end
  default['apache']['lib_dir']     = node['kernel']['machine'] =~ /^i[36]86$/ ? '/usr/lib/apache2' : '/usr/lib64/apache2'
  default['apache']['libexec_dir'] = node['apache']['lib_dir']
when 'debian', 'ubuntu'
  default['apache']['package']     = 'apache2'
  default['apache']['perl_pkg']    = 'perl'
  if node['apache']['mpm'] == 'prefork'
    default['apache']['devel_package'] = 'apache2-prefork-dev'
  else
    default['apache']['devel_package'] = 'apache2-dev'
  end
  default['apache']['apachectl']   = '/usr/sbin/apache2ctl'
  default['apache']['dir']         = '/etc/apache2'
  default['apache']['log_dir']     = '/var/log/apache2'
  default['apache']['error_log']   = 'error.log'
  default['apache']['access_log']  = 'access.log'
  default['apache']['user']        = 'www-data'
  default['apache']['group']       = 'www-data'
  default['apache']['binary']      = '/usr/sbin/apache2'
  default['apache']['conf_dir']    = '/etc/apache2'
  default['apache']['cgibin_dir']  = '/usr/lib/cgi-bin'
  default['apache']['icondir']     = '/usr/share/apache2/icons'
  default['apache']['cache_dir']   = '/var/cache/apache2'
  default['apache']['run_dir']     = '/var/run/apache2'
  default['apache']['lock_dir']    = '/var/lock/apache2'
  # this should use COOK-3917 to educate the initscript of the pid location
  if node['apache']['version'] == '2.4'
    default['apache']['pid_file']    = '/var/run/apache2/apache2.pid'
    default['apache']['docroot_dir'] = '/var/www/html'
  else
    default['apache']['pid_file']    = '/var/run/apache2.pid'
    default['apache']['docroot_dir'] = '/var/www'
  end
  default['apache']['lib_dir']       = '/usr/lib/apache2'
  default['apache']['build_dir']     = '/usr/share/apache2'
  default['apache']['libexec_dir']   = "#{node['apache']['lib_dir']}/modules"
  default['apache']['default_site_name'] = '000-default'
when 'arch'
  default['apache']['package']     = 'apache'
  default['apache']['perl_pkg']    = 'perl'
  # default['apache']['apachectl']   = '/usr/sbin/apachectl'
  default['apache']['dir']         = '/etc/httpd'
  default['apache']['log_dir']     = '/var/log/httpd'
  default['apache']['error_log']   = 'error.log'
  default['apache']['access_log']  = 'access.log'
  default['apache']['user']        = 'http'
  default['apache']['group']       = 'http'
  default['apache']['binary']      = '/usr/sbin/httpd'
  default['apache']['conf_dir']    = '/etc/httpd'
  default['apache']['docroot_dir'] = '/srv/http'
  default['apache']['cgibin_dir']  = '/usr/share/httpd/cgi-bin'
  default['apache']['icondir']     = '/usr/share/httpd/icons'
  default['apache']['cache_dir']   = '/var/cache/httpd'
  default['apache']['run_dir']     = '/var/run/httpd'
  default['apache']['lock_dir']    = '/var/run/httpd'
  default['apache']['pid_file']    = '/var/run/httpd/httpd.pid'
  default['apache']['lib_dir']     = '/usr/lib/httpd'
  default['apache']['libexec_dir']  = "#{node['apache']['lib_dir']}/modules"
when 'freebsd'
  if node['apache']['version'] == '2.4'
    default['apache']['package']     = 'apache24'
    default['apache']['dir']         = '/usr/local/etc/apache24'
    default['apache']['conf_dir']    = '/usr/local/etc/apache24'
    default['apache']['docroot_dir'] = '/usr/local/www/apache24/data'
    default['apache']['cgibin_dir']  = '/usr/local/www/apache24/cgi-bin'
    default['apache']['icondir']     = '/usr/local/www/apache24/icons'
    default['apache']['cache_dir']   = '/var/cache/apache24'
    default['apache']['run_dir']     = '/var/run'
    default['apache']['lock_dir']    = '/var/run'
    default['apache']['lib_dir']     = '/usr/local/libexec/apache24'
  else
    default['apache']['package']     = 'apache22'
    default['apache']['dir']         = '/usr/local/etc/apache22'
    default['apache']['conf_dir']    = '/usr/local/etc/apache22'
    default['apache']['docroot_dir'] = '/usr/local/www/apache22/data'
    default['apache']['cgibin_dir']  = '/usr/local/www/apache22/cgi-bin'
    default['apache']['icondir']     = '/usr/local/www/apache22/icons'
    default['apache']['cache_dir']   = '/var/cache/apache22'
    default['apache']['run_dir']     = '/var/run'
    default['apache']['lock_dir']    = '/var/run'
    default['apache']['lib_dir']     = '/usr/local/libexec/apache22'
  end
  default['apache']['devel_package'] = 'httpd-devel'
  default['apache']['perl_pkg']    = 'perl5'
  default['apache']['apachectl']   = '/usr/local/sbin/apachectl'
  default['apache']['pid_file']    = '/var/run/httpd.pid'
  default['apache']['log_dir']     = '/var/log'
  default['apache']['error_log']   = 'httpd-error.log'
  default['apache']['access_log']  = 'httpd-access.log'
  default['apache']['root_group']  = 'wheel'
  default['apache']['user']        = 'www'
  default['apache']['group']       = 'www'
  default['apache']['binary']      = '/usr/local/sbin/httpd'
  default['apache']['libexec_dir']  = node['apache']['lib_dir']
else
  default['apache']['package']     = 'apache2'
  default['apache']['devel_package'] = 'apache2-dev'
  default['apache']['perl_pkg']    = 'perl'
  default['apache']['dir']         = '/etc/apache2'
  default['apache']['log_dir']     = '/var/log/apache2'
  default['apache']['error_log']   = 'error.log'
  default['apache']['access_log']  = 'access.log'
  default['apache']['user']        = 'www-data'
  default['apache']['group']       = 'www-data'
  default['apache']['binary']      = '/usr/sbin/apache2'
  default['apache']['conf_dir']    = '/etc/apache2'
  default['apache']['docroot_dir'] = '/var/www'
  default['apache']['cgibin_dir']  = '/usr/lib/cgi-bin'
  default['apache']['icondir']     = '/usr/share/apache2/icons'
  default['apache']['cache_dir']   = '/var/cache/apache2'
  default['apache']['run_dir']     = 'logs'
  default['apache']['lock_dir']    = 'logs'
  default['apache']['pid_file']    = 'logs/httpd.pid'
  default['apache']['lib_dir']     = '/usr/lib/apache2'
  default['apache']['libexec_dir']  = "#{node['apache']['lib_dir']}/modules"
end

###
# These settings need the unless, since we want them to be tunable,
# and we don't want to override the tunings.
###

# General settings
if node['apache']['service_name'].nil?
  default['apache']['service_name'] = node['apache']['package']
end
default['apache']['listen_addresses']  = %w(*)
default['apache']['listen_ports']      = %w(80)
default['apache']['contact']           = 'ops@example.com'
default['apache']['timeout']           = 300
default['apache']['keepalive']         = 'On'
default['apache']['keepaliverequests'] = 100
default['apache']['keepalivetimeout']  = 5
default['apache']['locale'] = 'C'
default['apache']['sysconfig_additional_params'] = {}
default['apache']['default_site_enabled'] = false
default['apache']['default_site_port']    = '80'
default['apache']['access_file_name'] = '.htaccess'

# Security
default['apache']['servertokens']    = 'Prod'
default['apache']['serversignature'] = 'On'
default['apache']['traceenable']     = 'Off'

# mod_auth_openids
default['apache']['allowed_openids'] = []

# mod_status Allow list, space seprated list of allowed entries.
default['apache']['status_allow_list'] = '127.0.0.1 ::1'

# mod_status ExtendedStatus, set to 'true' to enable
default['apache']['ext_status'] = false

# mod_info Allow list, space seprated list of allowed entries.
default['apache']['info_allow_list'] = '127.0.0.1 ::1'

# Supported mpm list
default['apache']['mpm_support'] = %w(prefork worker event)

# Prefork Attributes
default['apache']['prefork']['startservers']        = 16
default['apache']['prefork']['minspareservers']     = 16
default['apache']['prefork']['maxspareservers']     = 32
default['apache']['prefork']['serverlimit']         = 256
default['apache']['prefork']['maxrequestworkers']   = 256
default['apache']['prefork']['maxconnectionsperchild'] = 10_000

# Worker Attributes
default['apache']['worker']['startservers']        = 4
default['apache']['worker']['serverlimit']         = 16
default['apache']['worker']['minsparethreads']     = 64
default['apache']['worker']['maxsparethreads']     = 192
default['apache']['worker']['threadlimit']         = 192
default['apache']['worker']['threadsperchild']     = 64
default['apache']['worker']['maxrequestworkers']   = 1024
default['apache']['worker']['maxconnectionsperchild'] = 0

# Event Attributes
default['apache']['event']['startservers']        = 4
default['apache']['event']['serverlimit']         = 16
default['apache']['event']['minsparethreads']     = 64
default['apache']['event']['maxsparethreads']     = 192
default['apache']['event']['threadlimit']         = 192
default['apache']['event']['threadsperchild']     = 64
default['apache']['event']['maxrequestworkers']   = 1024
default['apache']['event']['maxconnectionsperchild'] = 0

# mod_proxy settings
default['apache']['proxy']['require']    = 'all denied'
default['apache']['proxy']['order']      = 'deny,allow'
default['apache']['proxy']['deny_from']  = 'all'
default['apache']['proxy']['allow_from'] = 'none'

# Default modules to enable via include_recipe
default['apache']['default_modules'] = %w(
  status alias auth_basic authn_core authn_file authz_core authz_groupfile
  authz_host authz_user autoindex dir env mime negotiation setenvif
)

%w(log_config logio).each do |log_mod|
  default['apache']['default_modules'] << log_mod if %w(rhel fedora suse arch freebsd).include?(node['platform_family'])
end

if node['apache']['version'] == '2.4'
  %w(unixd).each do |unix_mod|
    default['apache']['default_modules'] << unix_mod if %w(rhel fedora suse arch freebsd).include?(node['platform_family'])
  end

  unless node['platform'] == 'amazon'
    default['apache']['default_modules'] << 'systemd' if %w(rhel fedora).include?(node['platform_family'])
  end
end

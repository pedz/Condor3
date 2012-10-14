#
# A class to help issue CMVC commands from a particular host.  It will
# be configured by the cmvc.yml file in the config directory (which
# will be loaded by an initializer).
module CmvcHost
  OurHost = Socket::gethostname.sub(/\..*/, '').downcase
  Config = YAML.load(File.open("#{Rails.root}/config/cmvc.yml"))[OurHost].symbolize_keys

  case Config[:method]
  when "ssh"
    def cmvc_command(cmd)
      Net::SSH.start(Config[:hostname], Config[:username]) do |ssh|
        # stolen from stack exchange
        # http://stackoverflow.com/questions/3386233/how-to-get-exit-status-with-rubys-netssh-library
        # def ssh_exec!(ssh, command)
        stdout_data = ""
        stderr_data = ""
        exit_code = nil
        exit_signal = nil
        ssh.open_channel do |channel|
          channel.exec(command) do |ch, success|
            unless success
              abort "FAILED: couldn't execute command (ssh.channel.exec)"
            end
            channel.on_data do |ch,data|
              stdout_data+=data
            end
            
            channel.on_extended_data do |ch,type,data|
              stderr_data+=data
            end
            
            channel.on_request("exit-status") do |ch,data|
              exit_code = data.read_long
            end
            
            channel.on_request("exit-signal") do |ch, data|
              exit_signal = data.read_long
            end
          end
        end
        ssh.loop
        [stdout_data, stderr_data, exit_code, exit_signal]
        # end



        stdout = ""
        stderr = ""
        ssh.exec!("#{Config[:path]}/#{cmd}") do |channel, stream, data|
          case stream
          when :stdout
            stdout << data
          when :stderr
            stderr << data
          end
        end
      end
    end

  when "local"
  end
end

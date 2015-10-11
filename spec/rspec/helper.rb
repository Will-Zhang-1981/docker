require "luna/rspec/formatters/checks"
[:yaml, :open3, :pry].map do |v|
  require v.to_s
end

def run(*cmd)
  stdout, stderr, status = "", "", 0
  Open3.popen3(*cmd.map(&:to_s)) do |i, o, e, wait| i.close
    while data = o.gets do stdout << data end
    while data = e.gets do stderr << data end
    status = wait.value.exitstatus if ! wait.value.success?
  end

  return {
    :stdout => stdout,
    :status => status,
    :stderr => stderr
  }
end

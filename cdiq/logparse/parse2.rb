require 'json'

class LogParser
  attr_reader :format

  module FormatType
    class Apache
      def parse_by_format line
        # vhost
        /"(\w+\.\w+\.\w+)"/ =~ line
        vhost = $1
        vhost = "null" if vhost.nil?

        # rhost
        /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/ =~ line
        rhost = $&
        rhost = null if rhost.nil?

        # user
        line.scan(/\-\s(\w+|\-)/)
        user = $1
        user = "null" if user.nil?

        line.scan(/\[(.*?)\]/)
        t = $1
        unless t.nil?
          t.scan(/(\d{2})\/(\w{3})\/(\d{4}):(\d{2}:(\d{2}):(\d{2}))/)
          time = Time.new($3,$2,$1,$4,$5,$6).strftime("%Y-%m-%d %H:%M:%S")
        else
          time = "null"
        end

        # method path protocol
        line.scan(/(GET|POST)\s(.*?)\s(HTTP\/\d\.\d)/)
        method,path,protocol = $1,$2,$3

        method = "null" if method.nil?
        path = "null" if path.nil?
        protocol = "null" if protocol.nil?

        # status bytes
        line.scan(/(\d{3})\s(\d{0,})/)
        status, bytes = $1,$2

        status = "null" if status.nil?
        bytes = "null" if bytes.nil?

        # referer agent duration
        line.scan(/\d{3}\s\d{0,}\s\"(.*?)\"\s\"(.*?)\"\s(\d{0,})/)
        referer, agent, duration = $1,$2,$3

        referer = "null" if referer.nil?
        agent = "null" if agent.nil?
        duration = "null" if duration.nil?

        prop = {
          vhost: vhost,
          rhost: rhost,
          user: user,
          time: time,
          method: method,
          path: path,
          protocol: protocol,
          status: status,
          bytes: bytes,
          referer: referer,
          agent: agent,
          duration: duration
        }

      end
    end

    class LTSV
      def parse_by_format line
        # vhost
        /vhost:(\w+\.\w+\.\w+)/ =~ line
        vhost = $1
        vhost = "null" if vhost.nil?

        # rhost
        /rhost:(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/ =~ line
        rhost = $1
        rhost = null if rhost.nil?

        # user
        line.scan(/user:(\w+|\-)/)
        user = $1
        user = "null" if user.nil?

        line.scan(/time:(.*?)\s/)
        t = $1
        unless t.nil?
          t.scan(/(\d{2})\/(\w{3})\/(\d{4}):(\d{2}:(\d{2}):(\d{2}))/)
          time = Time.new($3,$2,$1,$4,$5,$6).strftime("%Y-%m-%d %H:%M:%S")
        else
          time = "null"
        end

        # method path protocol
        line.scan(/method:(.*?)\s/)
        method = $1
        method = "null" if method.nil?

        line.scan(/path:(.*?)\s/)
        path = $1
        path = "null" if path.nil?

        line.scan(/protocol:(.*?)\s/)
        protocol = $1
        protocol = "null" if protocol.nil?

        # status bytes
        line.scan(/status:(\d{3})\s/)
        status = $1
        status = "null" if status.nil?

        line.scan(/bytes:(\d{0,})\s/)
        bytes = $1
        bytes = "null" if bytes.nil?

        # referer agent duration
        line.scan(/referer:(.*?)\s/)
        referer = $1
        referer = "null" if referer.nil?

        line.scan(/agent:(.*?)\sduration:(\d{0,})/)
        agent, duration = $1, $2
        agent = "null" if agent.nil?
        duration = "null" if duration.nil?

        prop = {
          vhost: vhost,
          rhost: rhost,
          user: user,
          time: time,
          method: method,
          path: path,
          protocol: protocol,
          status: status,
          bytes: bytes,
          referer: referer,
          agent: agent,
          duration: duration
        }
      end
    end
  end

  def initialize
    # Default Type
    @format = FormatType::Apache.new
  end

  # 出力する
  def display line
      prop = parse(line)
      STDOUT.puts JSON.generate(prop)
  end

  # 入力されたデータをパースする
  def parse(line)
    if /time:/ =~ line
      @format = FormatType::LTSV.new
    end
    # type別でわける
    @format.parse_by_format(line)
  end

end

LogParser.new.display(STDIN.gets)

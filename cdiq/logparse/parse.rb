require 'json'

class LogParser
  PROPERTIES = [:vhost,:rhost,:user,:time,:method,:path,:protocol,:status,:bytes,:referer,:agent,:duration]
  PROPERTIES.each { |prop| attr_reader prop }

  # クラスメソッド
  def LogParser.parse line
      set_properties(line)
      prop = {
        vhost: @vhost,
        rhost: @rhost,
        user: @user,
        time: @time,
        method: @method,
        path: @path,
        protocol: @protocol,
        status: @status,
        bytes: @status,
        referer: @referer,
        agent: @agent,
        duration: @duration
      }
      STDOUT.puts JSON.generate(prop)
  end

  # 入力されたデータをパースする
  def self.set_properties(line)
    # vhost
    /"(\w+\.\w+\.\w+)"/ =~ line
    @vhost = $1
    @vhost = "null" if @vhost.nil?

    # rhost
    /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/ =~ line
    @rhost = $&
    @rhost = null if @rhost.nil?

    # user
    line.scan(/\-\s(\w+|\-)/)
    @user = $1
    @user = "null" if @user.nil?

    line.scan(/\[(.*?)\]/)
    t = $1
    unless t.nil?
      t.scan(/(\d{2})\/(\w{3})\/(\d{4}):(\d{2}:(\d{2}):(\d{2}))/)
      @time = Time.new($3,$2,$1,$4,$5,$6).strftime("%Y-%m-%d %H:%M:%S")
    else
      @time = "null"
    end

    # method path protocol
    line.scan(/(GET|POST)\s(.*?)(HTTP\/\d\.\d)/)
    @method,@path,@protocol = $1,$2,$3

    @method = "null" if @method.nil?
    @path = "null" if @path.nil?
    @protocol = "null" if @protocol.nil?

    # status bytes
    elements = line.scan(/(\d{3})\s(\d{0,})/)
    @status, @bytes = $1,$2

    @status = "null" if @status.nil?
    @bytes = "null" if @bytes.nil?

    # referer agent duration
    line.scan(/\d{3}\s\d{0,}\s\"(.*?)\"\s\"(.*?)\"\s(\d{0,})/)
    @referer, @agent, @duration = $1,$2,$3

    @referer = "null" if @referer.nil?
    @agent = "null" if @agent.nil?
    @duration = "null" if @duration.nil?

  end

end

LogParser.parse(STDIN.gets)

require 'rest-client'
require 'json'

module MakerBlog
  class Client
    def list_posts
      response = RestClient.get('http://makerblog.herokuapp.com/posts', accept: 'application/json')
      posts = JSON.parse(response.body)
      posts.each do |post|
        p "#{post["name"]} posted #{post["title"]}"
        p "#{post["content"]}"
      end
    end

    def show_post(id)
      url = "http://makerblog.herokuapp.com/posts/#{id}"
      response = RestClient.get(url, accept: 'application/json')
      post = JSON.parse(response.body)
      puts "#{post["name"]} posted #{post["title"]}: #{post["content"]}"
    end

    def create_post(name, title, content)
      url = "http://makerblog.herokuapp.com/posts/"
      payload = {:post => {'name' => name, 'title' => title, 'content' => content}}
      response = RestClient.post(url, JSON.generate(payload), accept: 'application/json', content_type: 'application/json')
      posted = JSON.parse(response.body)
      puts "#{posted["name"]} posted #{posted["title"]}: #{posted["content"]}"
    end

    def edit_post(id, options = {})
      url = "http://makerblog.herokuapp.com/posts/#{id}"
      params = {}
      # can't figure this part out? Google "ruby options hash"
      params[:name] = options[:name] unless options[:name].nil?
      params[:title] = options[:title] unless options[:title].nil?
      params[:content] = options[:content] unless options[:content].nil?

      response = RestClient.put(url, post: params, accept: 'application/json', content_type: 'application/json')
      posted = JSON.parse(response.body)
      puts "#{posted["name"]} posted #{posted["title"]}: #{posted["content"]}"
    end

    def delete_post(id)
      url = "http://makerblog.herokuapp.com/posts/#{id}"
      response = RestClient.delete(url, accept: 'application/json')
      puts response.code
    end
  end
end

client = MakerBlog::Client.new
client.delete_post(19726)
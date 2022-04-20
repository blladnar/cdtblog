module Jekyll
  class TagPageGenerator < Generator
    safe true

    def generate(site)
      tags = site.posts.docs.flat_map { |post| post.data['tags'] || [] }.to_set
      tags.each do |tag|
        site.pages << TagPage.new(site, site.source, tag, site.posts.docs.first.data['background'])
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, tag, background)
      @site = site
      @base = base
      @dir  = File.join('posts/tag', tag)
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, 'posts'), 'tag.html')
      self.data['tag'] = tag
      self.data['title'] = "#{tag}"
      self.data['background'] = background
    end
  end
end

module Sinatra
  module ContentFor
    def content_for(key, &block)
      content_blocks[key.to_sym] << block
    end
    
    def yield_content(key, *args)
      content_blocks[key.to_sym].map do |content|
        content.call(*args)
      end.join
    end
    
    private
      
      def content_blocks
        @content_blocks ||= Hash.new {|h,k| h[k] = []}
      end
  end
  
  helpers ContentFor
  
end
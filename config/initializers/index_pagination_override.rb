module ActiveAdmin
  module Views
    module Pages
      class Index < Base
        
        protected
        
        def render_index
          renderer_class = find_index_renderer_class(config[:as])
          
          paginated_collection(collection, :entry_name => active_admin_config.resource_name, :download_links => false) do
            div :class => 'index_content' do
              insert_tag(renderer_class, config, collection)
            end
          end
        end
        
      end
    end
  end
end
      

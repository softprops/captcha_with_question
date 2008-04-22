# view mixins
module Soft
  module Props
    module CatchaWithQuestion
      module FormHelper
        def questionable_fields(form=nil)
          unless session[:logic].nil? && form.nil?
            contents = ''
            label_contents = ''
            text_contents = ''
            contents << form.hidden_field(:logic, :value=>session[:logic])
            label_contents << content_tag(:label, session[:logic], {})
            contents << content_tag(:p, label_contents, {})
            
            text_contents << form.text_field(:logic_solution)
            contents << content_tag(:p, text_contents, {})
            contents
          end
        end
      end
    end
  end
end
ActionView::Base.send(:include, Soft::Props::CatchaWithQuestion::FormHelper)

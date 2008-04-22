# controller mixins
module Soft
  module Props
    module CatchaWithQuestion
      module BeforeFilters
        def assign_captcha_question
          session[:logic] = Logic.new.question
        end
      end
    end
  end
end
 
ActionController::Base.send(:include, Soft::Props::CatchaWithQuestion::BeforeFilters)
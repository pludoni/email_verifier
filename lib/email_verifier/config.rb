module EmailVerifier
  module Config
    class << self
      attr_accessor :verifier_email
      attr_accessor :test_mode
      attr_accessor :ignore_failure_on

      def ignore_failure_on(&block)
        @ignore_failure_on_callback = block
      end

      def ignore_exception?(exception, value)
        return false unless @ignore_failure_on_callback

        @ignore_failure_on_callback.call(exception, value)
      end

      def reset
        @verifier_email = "nobody@nonexistant.com"
        @test_mode = false
        if defined?(Rails) and defined?(Rails.env) and Rails.env.test?
          @test_mode = true
        end
      end
    end
    self.reset
  end
end

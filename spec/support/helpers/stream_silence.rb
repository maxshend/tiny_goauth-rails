# frozen_string_literal: true

module Helpers
  module StreamSilence
    def silence_stdout(&block)
      silence_stream $stdout, &block
    end

    def silence_stream(stream)
      old_stream = stream.dup
      stream.reopen File::NULL
      stream.sync = true

      yield
    ensure
      stream.reopen old_stream
      old_stream.close
    end
  end
end

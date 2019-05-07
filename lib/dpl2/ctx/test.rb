require 'cl'

module Dpl
  module Ctx
    class Test < Cl::Ctx
      def initialize
        super('dpl')
      end

      def fold(name)
        cmds << "[fold] #{name}"
        yield.tap { cmds << "[unfold] #{name}" }
      end

      def script(name)
        cmds << "[script] #{name}"
      end

      def shell(cmd, opts = {})
        cmd = "#{cmd} > /dev/null 2>&1" if opts[:silence]
        cmds << cmd
      end

      def success?
        true
      end

      def info(msg)
        cmds << "[info] #{msg}"
      end

      def warn(msg)
        cmds << "[warn] #{msg}"
      end

      def deprecate_opt(old, new)
        warn("deprecated option #{old}, please use: #{new}")
      end

      def cmds
        @cmds ||= []
      end
    end
  end
end
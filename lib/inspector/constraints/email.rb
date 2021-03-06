module Inspector
  module Constraints
    class Email
      include Constraint

      PATTERN = begin
        if (RUBY_VERSION == '1.9.2' && RUBY_ENGINE == 'jruby' && JRUBY_VERSION <= '1.6.3') || RUBY_VERSION >= '1.9.2'
          # There is an obscure bug in jruby 1.6 that prevents matching
          # on unicode properties here. Remove this logic branch once
          # a stable jruby release fixes this.
          #
          # http://jira.codehaus.org/browse/JRUBY-5622
          #
          # There is a similar bug in preview releases of 1.9.3
          #
          # http://redmine.ruby-lang.org/issues/5126
          letter = 'a-zA-Z'
        else
          letter = 'a-zA-Z\p{L}'  # Changed from RFC2822 to include unicode chars
        end
        digit          = '0-9'
        atext          = "[#{letter}#{digit}\!\#\$\%\&\'\*+\/\=\?\^\_\`\{\|\}\~\-]"
        dot_atom_text  = "#{atext}+([.]#{atext}*)+"
        dot_atom       = dot_atom_text
        no_ws_ctl      = '\x01-\x08\x11\x12\x14-\x1f\x7f'
        qtext          = "[^#{no_ws_ctl}\\x0d\\x22\\x5c]"  # Non-whitespace, non-control character except for \ and "
        text           = '[\x01-\x09\x11\x12\x14-\x7f]'
        quoted_pair    = "(\\x5c#{text})"
        qcontent       = "(?:#{qtext}|#{quoted_pair})"
        quoted_string  = "[\"]#{qcontent}+[\"]"
        atom           = "#{atext}+"
        word           = "(?:#{atom}|#{quoted_string})"
        obs_local_part = "#{word}([.]#{word})*"
        local_part     = "(?:#{dot_atom}|#{quoted_string}|#{obs_local_part})"
        dtext          = "[#{no_ws_ctl}\\x21-\\x5a\\x5e-\\x7e]"
        dcontent       = "(?:#{dtext}|#{quoted_pair})"
        domain_literal = "\\[#{dcontent}+\\]"
        obs_domain     = "#{atom}([.]#{atom})+"
        domain         = "(?:#{dot_atom}|#{domain_literal}|#{obs_domain})"
        addr_spec      = "#{local_part}\@#{domain}"
        pattern        = /\A#{addr_spec}\z/u
      end

      def valid?(email)
        !(PATTERN =~ email).nil?
      end

      def to_s
        "be_an_email"
      end

      def inspect
        "#<email>"
      end
    end
  end
end
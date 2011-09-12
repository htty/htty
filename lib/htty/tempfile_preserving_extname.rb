require 'tempfile'

module HTTY; end

# Adds file-extension-preservation behavior to Tempfile.
class HTTY::TempfilePreservingExtname < Tempfile

private

  def make_tmpname(basename, n)
    extname = File.extname(basename)
    bare_basename = File.basename(basename, extname)
    "#{bare_basename}#{Process.pid}-#{n}#{extname}"
  end

end

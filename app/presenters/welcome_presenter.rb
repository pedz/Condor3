# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# Welcome page presenter
class WelcomePresenter < ApplicationPresenter
  def page_title
    "Welcome to Condor 3"
  end

  def help_text
    build_html do
      p do
        text 'The front page of Condor 3 has a number of input boxes with a submit button beside each one.'
        dl do
          dt 'swinfo'
          dd do
            text <<-T1
              Retrieves a table of hits that contain the item entered.  The
              item is assumed to be one of the following.  The match is case
              insensitive and is done in the order listed:
              T1
            dl do
              dt 'apar'
              dd do
                "Example: IV12345  Pattern: I[VXYZ][0-9]{5}"
              end
              
              dt 'cq defect'
              dd do
                text <<-T2
                  Two letters followed by six digits.
	          Example: AX058805 Pattern: [A-Z]{2}[0-9]{6}
                  T2
              end
              
              dt 'defect'
              dd do
                text 'A sequence of digits.  Example: 123456  Pattern: [0-9]+'
              end
              
              dt 'service pack'
              dd do
                text <<-T3
                  Example: 6100-07-04 for AIX service packs or VIOS 2.2.1.1 for
                  VIOS updates.  Patterns: [0-9]{4}-[0-9]{2}-[0-9]{2} or VIOS .*
                  T3
              end
              
              dt 'ptf'
              dd do
                text 'Example: U123456 Pattern: U[0-9]{6}'
              end
              
              dt 'fileset with vrmf'
              dd do
                text <<-T4
                  Example: bos.mp64 6.1.6.2 Pattern: A sequence containing
                  no spaces or colons, followed by a sequence of spaces or
                  colons (the separator), followed by another sequence
                  containing no spaces or colons.  The VRMF may be incomplete
                  such as bos.mp64:6.1.6 will get all the vrmf's matching a
                  vrmf of 6.1.6.*
                  T4
              end
              
              dt 'fileset'
              dd do
                text 'if no pattern above matches, the item is assumed to be a fileset name.'
              end
            end
          end
          
          dt 'which filesets'
          dd do
            text <<-T5
              Enter a path or a partial path to a file that is shipped with
              AIX such as "netinet" or "/usr/bin/cat".  The result will be a
              table of matching paths and the LPPs that shipped them.
              T5
          end
          
          dt 'sha1'
          dd do
            text <<-T6
              Enter a sha1 hash of a shipped AIX file such as
              "2a5af4afb28c2119c894697916b10cc590629549".  These can be
              generated by a command like "csum -h SHA1 /usr/bin/cat".  The
              result will be a table of paths that match the SHA1.
              T6
          end
          
          dt 'cmvc defect'
          dd do
            text 'Enter a defect number and view the CMVC defect.'
          end
          
          dt 'cmvc defect changes'
          dd do
            text 'Enter a defect number and view the changes made for the defect.'
          end
          
          dt 'file change history'
          dd do
            text 'Enter a path to a CMVC file and view the change history for the file.'
          end
        end
      end
    end
  end

  def welcome_form(name, path, param, text_label)
    form_tag path, id: "#{name}-form" do
      out = "\n"
      out << label_tag(param, text_label, class: "form-description")
      out << "\n"
      out << text_field_tag(param)
      out << "\n"
      out << submit_tag("Submit", id: "#{name}-submit")
      out.html_safe
    end
  end

  def vince
    if session[:user_name] == 'vjlayton@us.ibm.com'
      build_html do
        div.vince! do
          img src: asset_path('godzilla.jpg')
        end
      end
    end
  end
end

class ChangesController < ApplicationController
  def show
    @defect = params[:change]
    return redirect_to changes_path(@defect) if request.post?
    @changes = change_text(@defect)
  end

  private

  def change_text(defect)
    options = {
      :family => 'aix',
      :general => "Changes c, \
		 Defects d, \
		 Files f, \
		 Path p, \
		 Tracks t, \
		 Levels l, \
		 Releases r, \
		 Versions v, \
		 Versions prev \
		 ",
      :where => "d.name = '#{defect}' and \
		 d.id = t.defectid and \
		 c.trackid = t.id and \
		 f.id = c.fileid and \
		 f.pathid = p.id and \
		 t.releaseid = r.id and \
		 v.id = c.versionid and \
		 prev.id = v.previousId and \
                 l.id in ( \
		          select l.id \
                          from   Levels l, \
                                 LevelMembers lm \
                          where  lm.trackid = t.id and \
                                 l.id = lm.levelid and \
                               ( l.type = 'published' or \
                                 ( l.type = 'production' and \
                                   not exists ( \
                                       select * \
                                       from   Levels l, \
                                              LevelMembers lm \
                                       where  l.id = lm.levelid and \
                                              l.type = 'published' and \
                                              t.id = lm.trackid ) \
                                 ) \
                               ) \
                        union \
		          select l.id \
                          from   Levels l, \
                                 LevelMembers lm \
                          where  l.name is null and \
                                 not exists ( \
				     select * \
                                     from  Levels l, \
                                           LevelMembers lm \
                                     where l.id = lm.levelid and \
                                           l.type in ( 'production', \
                                                       'published' ) and \
                                           t.id = lm.trackid ) \
                        ) \
                 order by defect, release, path, sccsid",
      :select => "r.name as release, \
	          d.name as defect, \
		  l.name as level, \
		  v.SID as sccsid, \
		  p.name as path, \
		  c.type, \
		  d.reference, \
		  d.abstract, \
		  prev.SID as prev_sccsid"
    }
    user.cmvc.report!(options).lines.map { |line| Change.new(*line.split('|'))}
  end
end

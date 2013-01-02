describe("UpdAparDef", function() {
    it("index should start at 1", function() {
	var the_container, the_table, the_tbody, first_row, index;
	
	runs(function() {
	    loadFixtures('upd_apar_def_fixture.html');
	    condor3.upd_apar_def_ready_func_real("http://localhost/condor3/swinfos/648438/defect,%20apar,%20ptf/1");
	    the_container = $('.upd-apar-defs-container');
	    the_table = the_container.children('table');
	    the_tbody = the_table.children('tbody');
	});

	waitsFor(function () {
	    first_row = the_tbody.children('tr').first();
	    return first_row.length > 0;
	}, "'tr' elements never appeared", 750);

	runs(function() {
	    index = first_row.children('td:first-child');
	    expect(index.text()).toMatch(/\s*1\s*/);
	});
    });
});

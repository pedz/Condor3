describe("UpdAparDef", function() {
    beforeEach(function() {
	loadFixtures('upd_apar_def_fixture.html');
	condor3.upd_apar_def_ready_func_real("http://localhost/condor3/swinfos/648438/defect,%20apar,%20ptf/1");
    });

    it("index should start at 1", function() {
	var tbody = $('.upd-apar-defs-container tbody');
	var row1 = tbody.children('tr').first();
	var index = row1.children('td:first-child');
	console.log(tbody);
	expect(index[0].text).toEqual('1');
    });
});

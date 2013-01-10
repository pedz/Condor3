describe("UpdAparDef", function() {
    var the_container, the_table, the_tbody, first_row, first_tds;
    var second_row, second_tds, data, upd_apar_def;
    var columns = { 'index': 0,
		    'defect': 1,
		    'apar': 2,
		    'ptf': 3,
		    'abstract': 4,
		    'lpp': 5,
		    'vrmf': 6,
		    'version': 7,
		    'service_pack': 8
		  };

    function nth(column) {
	return [ "first",
		 "second",
		 "third",
		 "fourth",
		 "fifth",
		 "sixth",
		 "seventh",
		 "eighth",
		 "ninth",
		 "tenth"
	       ][column];
    };

    function str_pattern(s) {
	return new RegExp("\\s*" + s + "\\s*");
    };

    beforeEach(function onlyOnce() {
	if (onlyOnce.done)
	    return;
	onlyOnce.done = 1;
	loadFixtures('upd_apar_def_fixture.html');
	upd_apar_def = new condor3.UpdAparDef("http://localhost/condor3/swinfos/648438/defect,%20apar,%20ptf/1");
	the_container = $('.upd-apar-defs-container');
	the_table = the_container.children('table');
	the_tbody = the_table.children('tbody');
	first_row = the_tbody.children('tr:first-child')
	first_tds = first_row.children('td');
	second_row = the_tbody.children('tr:nth-child(2)')
	second_tds = second_row.children('td');
	data = JSON.parse(the_container.children('script').slice(0).text())[0];
    });

    describe("Each Row of the table", function () {
	it("the index in the " + nth(columns['index']) + " column should start at 1", function() {
	    var index = first_tds.slice(columns['index']);
	    expect(index.text()).toMatch(str_pattern('1'));
	});

	it("the defect should be in the " + nth(columns['defect']) + " column", function() {
	    var defect = first_tds.slice(columns['defect']);
	    expect(defect.text()).toMatch(str_pattern(data['defect']));
	});

	it("the apar should be in the " + nth(columns['apar']) + " column", function() {
	    var apar = first_tds.slice(columns['apar']);
	    expect(apar.text()).toMatch(str_pattern(data['apar']));
	});

	it("the ptf should be in the " + nth(columns['ptf']) + " column", function() {
	    var ptf = first_tds.slice(columns['ptf']);
	    expect(ptf.text()).toMatch(str_pattern(data['ptf']));
	});

	it("the abstract should be in the " + nth(columns['abstract']) + " column", function() {
	    var abstract = first_tds.slice(columns['abstract']);
	    expect(abstract.text()).toMatch(str_pattern(data['abstract']));
	});

	it("the lpp should be in the " + nth(columns['lpp']) + " column", function() {
	    var lpp = first_tds.slice(columns['lpp']);
	    expect(lpp.text()).toMatch(str_pattern(data['lpp']));
	});

	it("the vrmf should be in the " + nth(columns['vrmf']) + " column", function() {
	    var vrmf = first_tds.slice(columns['vrmf']);
	    expect(vrmf.text()).toMatch(str_pattern(data['vrmf']));
	});

	it("the version should be in the " + nth(columns['version']) + " column", function() {
	    var version = first_tds.slice(columns['version']);
	    expect(version.text()).toMatch(str_pattern(data['version']));
	});

	it("the service_pack should be in the " + nth(columns['service_pack']) + " column", function() {
	    var service_pack = first_tds.slice(columns['service_pack']);
	    expect(service_pack.text()).toMatch(str_pattern(data['service_pack']));
	});
    });

    it("next index should should be 2", function() {
	var index = second_tds.slice(columns['index']);
	expect(index.text()).toMatch(str_pattern('2'));
    });

    it("the next page to be fetched should be at the correct URL", function() {
	expect(upd_apar_def.next_page_url()).toEqual("http://localhost/condor3/swinfos/648438/defect,%20apar,%20ptf/2.json");
    });
});

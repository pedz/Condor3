/*  -*- coding: utf-8 -*-
 * 
 *  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
 *  All Rights Reserved
 */
describe("UpdAparDef", function() {
    var upd_apar_def;
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

    function str_pattern(s) {
	return new RegExp("\\s*" + s + "\\s*");
    };

    /*
     * This is a duplicate copy on purpose.  I didn't want to trust
     * the real code by testing it with the same function.
     */
    function local_swinfo_path(v) {
	return "/swinfos/" + v + "/defect, apar, ptf/1";
    }

    beforeEach(function() {
	loadFixtures('upd_apar_def_fixture.html');
	mock_$();
	$(window).off('scroll');
	upd_apar_def = new condor3.UpdAparDef("http://localhost/condor3/swinfos/648438/-defect,%20apar,%20ptf/1");
    });

    it("should render all the columns correctly", function() {
	var the_container = $('.upd-apar-defs-container');
	var the_table = the_container.children('table');
	var the_tbody = the_table.children('tbody');
	var first_row = the_tbody.children('tr:first-child')
	var first_tds = first_row.children('td');
	var data = JSON.parse(the_container.children('script').eq(0).text())[0];

	var index = first_tds.eq(columns['index']);
	expect(index.text()).toMatch(str_pattern('1'));

	var defect = first_tds.eq(columns['defect']);
	expect(defect.text()).toMatch(str_pattern(data['defect']));

	var apar = first_tds.eq(columns['apar']);
	expect(apar.text()).toMatch(str_pattern(data['apar']));

	var ptf = first_tds.eq(columns['ptf']);
	expect(ptf.text()).toMatch(str_pattern(data['ptf']));

	var abstract = first_tds.eq(columns['abstract']);
	expect(abstract.text()).toMatch(str_pattern(data['abstract']));

	var lpp = first_tds.eq(columns['lpp']);
	expect(lpp.text()).toMatch(str_pattern(data['lpp']));

	var vrmf = first_tds.eq(columns['vrmf']);
	expect(vrmf.text()).toMatch(str_pattern(data['vrmf']));

	var version = first_tds.eq(columns['version']);
	expect(version.text()).toMatch(str_pattern(data['version']));

	var service_pack = first_tds.eq(columns['service_pack']);
	expect(service_pack.text()).toMatch(str_pattern(data['service_pack']));
    });

    it("index in second row should be 2", function() {
	var the_container = $('.upd-apar-defs-container');
	var the_table = the_container.children('table');
	var the_tbody = the_table.children('tbody');
	var second_row = the_tbody.children('tr:nth-child(2)')
	var second_tds = second_row.children('td');
	var index = second_tds.eq(columns['index']);
	expect(index.text()).toMatch(str_pattern('2'));
    });

    it("should properly indicate the sorting in the header", function() {
	var table_headers = $('.upd-apar-defs-container thead th');
	var temp;

	temp = table_headers.eq(columns['defect']).find('.sort');
	expect(temp).toHaveClass('sort-down');
	expect(temp).toHaveClass('sort-pos-1');

	temp = table_headers.eq(columns['apar']).find('.sort');
	expect(temp).toHaveClass('sort-up');
	expect(temp).toHaveClass('sort-pos-2');

	temp = table_headers.eq(columns['ptf']).find('.sort');
	expect(temp).toHaveClass('sort-up');
	expect(temp).toHaveClass('sort-pos-3');

	['abstract', 'lpp', 'vrmf', 'version', 'service_pack'].forEach(function(name) {
	    temp = table_headers.eq(columns[name]).find('.sort');
	    expect(temp).toHaveClass('sortable');
	});
    });

    describe("myScrollFunction", function() {
	it("should be called on the window scroll event", function() {
	    expect($(window)).toHandleWith('scroll', upd_apar_def.myScrollFunction);
	});

    	it("should not call ajax with page scrolled to the top", function() {
	    var proxy = spy$(document, 'scrollTop').andReturn(0);
	    jasmine.Ajax.useMock();
    	    upd_apar_def.myScrollFunction('dog');
	    expect(proxy.spy).toHaveBeenCalled();
	    expect(mostRecentAjaxRequest()).toBeNull();
    	});

	describe("Endless Page", function() {
	    var all_trs;
	    var initial_length;
	    var top;
	    var proxy;
	    var request;
	    
	    function get_all_trs() {
		return $('table.upd_apar_defs tbody tr');
	    };
		
	    beforeEach(function() {
		all_trs = get_all_trs();
		initial_length = all_trs.length;
		top = all_trs.slice(-1).offset().top;

		/* Return the value of top for scrollTop */
		proxy = spy$(document, 'scrollTop').andReturn(top);
		jasmine.Ajax.useMock();
    		upd_apar_def.myScrollFunction('dog');
		request = mostRecentAjaxRequest();
	    });

    	    it("should request next data when page is scrolled to the bottom", function() {
		var last_index;

		expect(proxy.spy).toHaveBeenCalled();
		expect(request).not.toBeNull();
		expect(request.url)
		    .toEqual("http://localhost/condor3/swinfos/648438/-defect,%20apar,%20ptf/2.json");

		request.response(TestResponses.first_success);
		all_trs = get_all_trs();
		expect(all_trs.length).toBeGreaterThan(initial_length);

		/*
		 * Check the index column to make sure it increments by
		 * one the whole way through the table
		 */
		all_trs.each(function (index) {
		    expect( $(this).find('td:first-child').text() )
			.toMatch(str_pattern((index + 1).toString()));
		    last_index = index;
		});
		expect(all_trs.length).toEqual(last_index + 1);
    	    });

	    it("should request third set of data when page is scrolled to the bottom again", function() {
		var proxy2;

		request.response(TestResponses.first_success);
		all_trs = get_all_trs();
		/* now pretend to scroll to the (new) bottom */
		top = all_trs.slice(-1).offset().top;
    		upd_apar_def.myScrollFunction('dog'); // 2nd call
		request = mostRecentAjaxRequest();

		expect(request).not.toBeNull();
		expect(request.url)
		    .toEqual("http://localhost/condor3/swinfos/648438/-defect,%20apar,%20ptf/3.json");
		request.response(TestResponses.second_success);
		expect($(window)).not.toHandle('scroll');
	    });
	});
    });

    describe("Clicking on the table headers", function() {
	var table_headers;

	beforeEach(function() {
	    table_headers = $('.upd-apar-defs-container thead th');
	});

	it("should negate the order when first sort column header is clicked", function() {
	    spyOn(upd_apar_def, 'setLocation');
	    table_headers.eq(columns['defect']).find('.upd_apar_defs_header_span').click();
	    expect(upd_apar_def.setLocation)
		.toHaveBeenCalledWith("http://localhost/condor3/swinfos/648438/defect, apar, ptf/1");
	    table_headers.eq(columns['defect']).find('.upd_apar_defs_header_span').click();
	    expect(upd_apar_def.setLocation)
		.toHaveBeenCalledWith("http://localhost/condor3/swinfos/648438/-defect, apar, ptf/1");
	});

	it("should reorder to  2nd, 1st, 3rd when the 2nd column is clicked", function() {
	    spyOn(upd_apar_def, 'setLocation');
	    table_headers.eq(columns['apar']).find('.upd_apar_defs_header_span').click();
	    expect(upd_apar_def.setLocation)
		.toHaveBeenCalledWith("http://localhost/condor3/swinfos/648438/apar, -defect, ptf/1");
	    table_headers.eq(columns['apar']).find('.upd_apar_defs_header_span').click();
	    expect(upd_apar_def.setLocation)
		.toHaveBeenCalledWith("http://localhost/condor3/swinfos/648438/-apar, -defect, ptf/1");
	});

	it("should reorder to  3rd, 1st, 2nd when the 3nd column is clicked", function() {
	    spyOn(upd_apar_def, 'setLocation');
	    table_headers.eq(columns['ptf']).find('.upd_apar_defs_header_span').click();
	    expect(upd_apar_def.setLocation)
		.toHaveBeenCalledWith("http://localhost/condor3/swinfos/648438/ptf, -defect, apar/1");
	    table_headers.eq(columns['ptf']).find('.upd_apar_defs_header_span').click();
	    expect(upd_apar_def.setLocation)
		.toHaveBeenCalledWith("http://localhost/condor3/swinfos/648438/-ptf, -defect, apar/1");
	});

	it("should reorder to  new, 1st, 2nd when a new column is clicked", function() {
	    spyOn(upd_apar_def, 'setLocation');
	    table_headers.eq(columns['lpp']).find('.upd_apar_defs_header_span').click();
	    expect(upd_apar_def.setLocation)
		.toHaveBeenCalledWith("http://localhost/condor3/swinfos/648438/lpp, -defect, apar/1");
	    table_headers.eq(columns['lpp']).find('.upd_apar_defs_header_span').click();
	    expect(upd_apar_def.setLocation)
		.toHaveBeenCalledWith("http://localhost/condor3/swinfos/648438/-lpp, -defect, apar/1");
	});
    });

    describe("The Context Menus", function () {
	/*
	 * Each td (except for the first which is used for the index) in
	 * the table looks like this:
	 *
	 * <td class='upd_apar_def-defect upd_apar_def_dual_button'>
	 *   <span class='upd_apar_def_outer_td_span'>
	 *     {{link_to ~swinfo_path(defect) "upd_apar_def_link" defect /}}
	 *     <span class='upd_apar_def_inner_td_span'>
	 *       where the arrow is displayed
	 *     </span>
	 *     <ul class='upd_apar_def_commands' style='display: none;'>
	 *       <li>Show CMVC Defect</li>
	 *       <li>Show Code Changes</li>
	 *       <li>Show APAR Draft</li>
	 *     </ul>
	 *   </span>
	 * </td>
	 *
	 * The upd_apar_def-defect class changes but the other classes
	 * stay the same and the list of ``commands'' (the <li> entries)
	 * also change.
	 */
	var td_class = 'upd_apar_def_dual_button';
	var outter_span_class = 'upd_apar_def_outer_td_span';
	var arrow_span_class = 'upd_apar_def_inner_td_span';
	var cmd_list_class = 'upd_apar_def_commands';
	var test_td;
	var arrow;
	var cmd_list;

	beforeEach(function () {
	    test_td = $('.upd-apar-defs-container tbody tr:nth-child(6) td:nth-child(2)');
	    arrow = test_td.find('.' + arrow_span_class);
	    cmd_list = test_td.find('.' + cmd_list_class);
	});

	afterEach(function () {
	    $('div.pedz-overlay').remove();
	});

	it("should initially have the commands hidden and the arrow visable", function () {
	    expect(test_td).toHaveClass(td_class); // sanity check test selector
	    expect(test_td.length).toEqual(1);	   // another sanity check
	    expect(arrow).toBeVisible();
	    expect(cmd_list).toBeHidden();
	});

	it("should hide arrow and display commands when arrow is clicked", function () {
	    arrow.click();
	    expect(arrow).toBeHidden();
	    expect(cmd_list).toBeVisible();
	});
    });

    describe("The Defect Column", function () {
	var defect;
	var data;

	beforeEach(function() {
	    defect = $('.upd-apar-defs-container tbody tr:first-child td:nth-child(2)');
	    data = JSON.parse($('.upd-apar-defs-container script').eq(0).text())[0];
	});

	it("should have a link to swinfo the defect", function () {
	    expect(defect.find('a').attr('href')).toEqual(local_swinfo_path(data['defect']));
	});
    });
});

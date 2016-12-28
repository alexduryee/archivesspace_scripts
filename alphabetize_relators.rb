# uses ruby 1.9.3 - sorry 'bout that!
require 'json'
require 'http'
require 'uri'

code_mappings = {'1335' => '226',
				'1334' => '226',
				'1333' => '225',
				'1332' => '223',
				'1331' => '222',
				'1330' => '222',
				'1329' => '220',
				'1328' => '215',
				'1327' => '215',
				'1326' => '201',
				'1325' => '199',
				'1324' => '190',
				'1323' => '184',
				'1322' => '180',
				'1321' => '168',
				'1320' => '166',
				'1319' => '163',
				'1318' => '161',
				'1317' => '149',
				'1316' => '147',
				'1315' => '142',
				'1314' => '134',
				'1313' => '115',
				'1312' => '115',
				'1311' => '112',
				'1310' => '107',
				# 1309 is -gft, which we don't really want
				# add here if you want it in your list
				'1308' => '101',
				'1307' => '100',
				'1306' => '100',
				'1305' => '98',
				'1304' => '94',
				'1303' => '89',
				'1302' => '89',
				'1301' => '74',
				'1300' => '58',
				'1299' => '49',
				'1298' => '47',
				'1297' => '30',
				'1296' => '29',
				'1295' => '29',
				'1294' => '16',
				'1293' => '8',
				'1292' => '8',
				'1291' => '2',
				'1290' => '0'}


@base_url = 'http://YOUR-ARCHIVESSPACE-INSTANCE-URL/'
login = HTTP.post("#{@base_url}users/ADMIN-USER/login", :form => {:password => "ADMIN-PASSWORD"})

if (login.code == 200)
	@active_token = JSON.parse(login.to_s)['session']
	@active_token_created = Time.now.to_i
end

code_mappings.each do |id, newpos|
	oldpos = JSON.parse(HTTP.with(:x_archivesspace_session => @active_token).get(URI.escape("#{@base_url}config/enumeration_values/#{id}")))['position']
	while oldpos.to_i > newpos.to_i
		oldpos = oldpos.to_i - 1
		puts HTTP.with(:x_archivesspace_session => @active_token).post(URI.escape("#{@base_url}config/enumeration_values/#{id}/position"), :params => {:position => oldpos})
	end
end

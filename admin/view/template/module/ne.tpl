<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

echo $header; ?>
<div id="content">
<div class="breadcrumb">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
	<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
	<?php } ?>
</div>
<?php if ($error_warning) { ?>
	<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<div class="box">
	<div class="heading">
		<h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
		<div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a>
			<a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
		</div>
	</div>
	<div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
    	<input type="hidden" name="ne_embedded_images" value="0" />
		<?php if (isset($licensor)) { ?>
		<table class="form">
			<tr>
				<td colspan="2">
					<span style='text-align: center;'><b><?php echo $text_licence_info; ?></b></span>
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_transaction_email; ?></td>
				<td><input type="text" name="email" value="" /></td>
			</tr>
			<tr>
				<td><?php echo $entry_transaction_id; ?></td>
				<td><input type="text" name="transaction_id" value="" /></td>
			</tr>
		</table>
		<?php } else { ?>
		<table class="form">
				<tr>
					<td colspan="2">
						<span style='text-align: center;'><b><?php echo $text_throttle_settings; ?></b></span>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_use_throttle; ?></td>
					<td>
						<?php if($ne_throttle) {
						$checked1 = ' checked="checked"';
						$checked0 = '';
						} else {
						$checked1 = '';
						$checked0 = ' checked="checked"';
						} ?>
					<label for="ne_throttle_1"><?php echo $entry_yes; ?></label>
					<input type="radio"<?php echo $checked1; ?> id="ne_throttle_1" name="ne_throttle" value="1" />
					<label for="ne_throttle_0"><?php echo $entry_no; ?></label>
					<input type="radio"<?php echo $checked0; ?> id="ne_throttle_0" name="ne_throttle" value="0" />
					</td>
				</tr>
				<tbody id="throttle">
				<tr>
					<td><?php echo $entry_throttle_emails; ?></td>
					<td><input type="text" name="ne_throttle_count" value="<?php echo $ne_throttle_count; ?>" size="3" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_throttle_time; ?></td>
					<td>
						<select name="ne_throttle_time">
							<option value="3600" <?php echo $ne_throttle_time == '3600' ? ' selected="selected"' : "" ?>>1</option>
							<option value="7200" <?php echo $ne_throttle_time == '7200' ? ' selected="selected"' : "" ?>>2</option>
							<option value="10800" <?php echo $ne_throttle_time == '10800' ? ' selected="selected"' : "" ?>>3</option>
							<option value="14400" <?php echo $ne_throttle_time == '14400' ? ' selected="selected"' : "" ?>>4</option>
						</select>
					</td>
				</tr>
				</tbody>
				<tr>
					<td colspan="2">
						<span style='text-align: center;'><b><?php echo $text_smtp_settings; ?></b></span>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_use_smtp; ?></td>
					<td>
						<?php if($ne_use_smtp) {
						$checked1 = ' checked="checked"';
						$checked0 = '';
						} else {
						$checked1 = '';
						$checked0 = ' checked="checked"';
						} ?>
					<label for="ne_smtp_1"><?php echo $entry_yes; ?></label>
					<input type="radio"<?php echo $checked1; ?> id="ne_smtp_1" name="ne_use_smtp" value="1" />
					<label for="ne_smtp_0"><?php echo $entry_no; ?></label>
					<input type="radio"<?php echo $checked0; ?> id="ne_smtp_0" name="ne_use_smtp" value="0" />
					</td>
				</tr>
				<tbody id="smtp">
				<tr>
					<td><?php echo $entry_stores; ?></td>
					<td>
						<?php array_unshift($stores, array('store_id' => 0, 'name' => $text_default)); ?>
						<div id="smtp_stores" class="htabs">
							<?php foreach ($stores as $store) { ?>
							<a href="#smtp_stores<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></a>
							<?php } ?>
						</div>
						<?php foreach ($stores as $store) { ?>
						<div id="smtp_stores<?php echo $store['store_id']; ?>">
							<table class="form">
								<tr>
									<td><?php echo $entry_mail_protocol; ?></td>
									<td><select name="ne_smtp[<?php echo $store['store_id']; ?>][protocol]">
										<?php if (isset($ne_smtp[$store['store_id']]['protocol']) && $ne_smtp[$store['store_id']]['protocol'] == 'mail') { ?>
										<option value="mail" selected="selected"><?php echo $text_mail; ?></option>
										<?php } else { ?>
										<option value="mail"><?php echo $text_mail; ?></option>
										<?php } ?>
										<?php if (isset($ne_smtp[$store['store_id']]['protocol']) && $ne_smtp[$store['store_id']]['protocol'] == 'smtp') { ?>
										<option value="smtp" selected="selected"><?php echo $text_smtp; ?></option>
										<?php } else { ?>
										<option value="smtp"><?php echo $text_smtp; ?></option>
										<?php } ?>
									</select></td>
								</tr>
								<tr>
									<td><?php echo $entry_email; ?></td>
									<td><input type="text" name="ne_smtp[<?php echo $store['store_id']; ?>][email]" value="<?php echo isset($ne_smtp[$store['store_id']]['email']) ? $ne_smtp[$store['store_id']]['email'] : ''; ?>" /></td>
								</tr>
								<tr>
									<td><?php echo $entry_mail_parameter; ?></td>
									<td><input type="text" name="ne_smtp[<?php echo $store['store_id']; ?>][parameter]" value="<?php echo isset($ne_smtp[$store['store_id']]['parameter']) ? $ne_smtp[$store['store_id']]['parameter'] : ''; ?>" /></td>
								</tr>
								<tr>
									<td><?php echo $entry_smtp_host; ?></td>
									<td><input type="text" name="ne_smtp[<?php echo $store['store_id']; ?>][host]" value="<?php echo isset($ne_smtp[$store['store_id']]['host']) ? $ne_smtp[$store['store_id']]['host'] : ''; ?>" /></td>
								</tr>
								<tr>
									<td><?php echo $entry_smtp_username; ?></td>
									<td><input type="text" name="ne_smtp[<?php echo $store['store_id']; ?>][username]" value="<?php echo isset($ne_smtp[$store['store_id']]['username']) ? $ne_smtp[$store['store_id']]['username'] : ''; ?>" /></td>
								</tr>
								<tr>
									<td><?php echo $entry_smtp_password; ?></td>
									<td><input type="text" name="ne_smtp[<?php echo $store['store_id']; ?>][password]" value="<?php echo isset($ne_smtp[$store['store_id']]['password']) ? $ne_smtp[$store['store_id']]['password'] : ''; ?>" /></td>
								</tr>
								<tr>
									<td><?php echo $entry_smtp_port; ?></td>
									<td><input type="text" name="ne_smtp[<?php echo $store['store_id']; ?>][port]" value="<?php echo isset($ne_smtp[$store['store_id']]['port']) ? $ne_smtp[$store['store_id']]['port'] : '25'; ?>" /></td>
								</tr>
								<tr>
									<td><?php echo $entry_smtp_timeout; ?></td>
									<td><input type="text" name="ne_smtp[<?php echo $store['store_id']; ?>][timeout]" value="<?php echo isset($ne_smtp[$store['store_id']]['timeout']) ? $ne_smtp[$store['store_id']]['timeout'] : '5'; ?>" /></td>
								</tr>
							</table>
						</div>
						<?php } ?>
					</td>
				</tr>
				</tbody>
				<!--
				<tr>
					<td colspan="2">
						<span style='text-align: center;'><b><?php echo $text_bounce_settings; ?></b></span>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_use_bounce_check; ?></td>
					<td>
						<?php if($ne_bounce) {
						$checked1 = ' checked="checked"';
						$checked0 = '';
						} else {
						$checked1 = '';
						$checked0 = ' checked="checked"';
						} ?>
					<label for="ne_bounce_1"><?php echo $entry_yes; ?></label>
					<input type="radio"<?php echo $checked1; ?> id="ne_bounce_1" name="ne_bounce" value="1" />
					<label for="ne_bounce_0"><?php echo $entry_no; ?></label>
					<input type="radio"<?php echo $checked0; ?> id="ne_bounce_0" name="ne_bounce" value="0" />
					</td>
				</tr>
				<tbody id="bounce">
				<tr>
					<td><?php echo $entry_bounce_email; ?></td>
					<td><input type="text" name="ne_bounce_email" value="<?php echo $ne_bounce_email; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_bounce_pop3_server; ?></td>
					<td><input type="text" name="ne_bounce_pop3_server" value="<?php echo $ne_bounce_pop3_server; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_bounce_pop3_user; ?></td>
					<td><input type="text" name="ne_bounce_pop3_user" value="<?php echo $ne_bounce_pop3_user; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_bounce_pop3_password; ?></td>
					<td><input type="password" name="ne_bounce_pop3_password" value="<?php echo $ne_bounce_pop3_password; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_bounce_pop3_port; ?></td>
					<td><input type="text" name="ne_bounce_pop3_port" value="<?php echo $ne_bounce_pop3_port; ?>" size="3" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_bounce_delete; ?></td>
					<td>
						<?php if($ne_bounce_delete) {
						$checked1 = ' checked="checked"';
						$checked0 = '';
						} else {
						$checked1 = '';
						$checked0 = ' checked="checked"';
						} ?>
					<label for="ne_bounce_delete_1"><?php echo $entry_yes; ?></label>
					<input type="radio"<?php echo $checked1; ?> id="ne_bounce_delete_1" name="ne_bounce_delete" value="1" />
					<label for="ne_bounce_delete_0"><?php echo $entry_no; ?></label>
					<input type="radio"<?php echo $checked0; ?> id="ne_bounce_delete_0" name="ne_bounce_delete" value="0" />
					</td>
				</tr>
				</tbody>
				-->
				<tr>
					<td colspan="2">
						<span style='text-align: center;'><b><?php echo $text_general_settings; ?></b></span>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_sent_retries; ?></td>
					<td><input type="text" name="ne_sent_retries" value="<?php echo $ne_sent_retries; ?>" size="3" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_cron_code; ?></td>
					<td>
						<pre><?php echo $cron_url; ?></pre>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_cron_help; ?></td>
					<td>
						<pre><?php echo $text_help; ?></pre>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_list; ?></td>
					<td>
						<div id="list_stores" class="htabs">
				            <?php foreach ($stores as $store) { ?>
				            <a href="#list_stores<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></a>
				            <?php } ?>
				        </div>
				        <?php $list_row = array(); ?>
				        <?php foreach ($stores as $store) { ?>
					      <div id="list_stores<?php echo $store['store_id']; ?>">
							<table id="list<?php echo $store['store_id']; ?>" class="list" style="width:auto;">
						        <thead>
						          <tr>
						            <td class="left"><?php echo $entry_name; ?></td>
						            <td></td>
						          </tr>
						        </thead>
						        <?php $list_row[$store['store_id']] = 1; ?>
						        <?php if (isset($list_data[$store['store_id']]) && $list_data[$store['store_id']]) foreach ($list_data[$store['store_id']] as $list) { ?>
						        <tbody id="list-row-<?php echo $store['store_id']; ?>-<?php echo $list_row[$store['store_id']]; ?>">
						          <tr>
						            <td class="left">
						              <?php foreach ($languages as $language) { ?>
						              <input type="text" name="ne_marketing_list[<?php echo $store['store_id']; ?>][<?php echo $list_row[$store['store_id']]; ?>][<?php echo $language['language_id']; ?>]" value="<?php echo isset($list[$language['language_id']]) ? $list[$language['language_id']] : ''; ?>" />
						              <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
						              <?php } ?>
						            </td>
						            <td class="left"><a onclick="$('#list-row-<?php echo $store['store_id']; ?>-<?php echo $list_row[$store['store_id']]; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
						          </tr>
						        </tbody>
						        <?php $list_row[$store['store_id']] = $list_row[$store['store_id']] + 1; ?>
						        <?php } ?>
						        <tfoot>
						          <tr>
						            <td></td>
						            <td class="left"><a onclick="addList(<?php echo $store['store_id']; ?>);" class="button"><span><?php echo $button_add_list; ?></span></a></td>
						          </tr>
						        </tfoot>
						      </table>
						  </div>
						<?php } ?>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<span style='text-align: center;'><b><?php echo $text_module_localization; ?></b></span>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_months; ?></td>
					<td>
						<div id="languages_months" class="htabs">
				            <?php foreach ($languages as $language) { ?>
				            <a href="#language_months<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
				            <?php } ?>
				        </div>
				        <?php foreach ($languages as $language) { ?>
					      <div id="language_months<?php echo $language['language_id']; ?>">
					        <table class="form">
					          <tr>
								<td><?php echo $entry_january; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][0]" size="100" value="<?php echo isset($ne_months[$language['language_id']][0]) ? $ne_months[$language['language_id']][0] : $entry_january; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_february; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][1]" size="100" value="<?php echo isset($ne_months[$language['language_id']][1]) ? $ne_months[$language['language_id']][1] : $entry_february; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_march; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][2]" size="100" value="<?php echo isset($ne_months[$language['language_id']][2]) ? $ne_months[$language['language_id']][2] : $entry_march; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_april; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][3]" size="100" value="<?php echo isset($ne_months[$language['language_id']][3]) ? $ne_months[$language['language_id']][3] : $entry_april; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_may; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][4]" size="100" value="<?php echo isset($ne_months[$language['language_id']][4]) ? $ne_months[$language['language_id']][4] : $entry_may; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_june; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][5]" size="100" value="<?php echo isset($ne_months[$language['language_id']][5]) ? $ne_months[$language['language_id']][5] : $entry_june; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_july; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][6]" size="100" value="<?php echo isset($ne_months[$language['language_id']][6]) ? $ne_months[$language['language_id']][6] : $entry_july; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_august; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][7]" size="100" value="<?php echo isset($ne_months[$language['language_id']][7]) ? $ne_months[$language['language_id']][7] : $entry_august; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_september; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][8]" size="100" value="<?php echo isset($ne_months[$language['language_id']][8]) ? $ne_months[$language['language_id']][8] : $entry_september; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_october; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][9]" size="100" value="<?php echo isset($ne_months[$language['language_id']][9]) ? $ne_months[$language['language_id']][9] : $entry_october; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_november; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][10]" size="100" value="<?php echo isset($ne_months[$language['language_id']][10]) ? $ne_months[$language['language_id']][10] : $entry_november; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_december; ?></td>
								<td><input type="text" name="ne_months[<?php echo $language['language_id']; ?>][11]" size="100" value="<?php echo isset($ne_months[$language['language_id']][11]) ? $ne_months[$language['language_id']][11] : $entry_december; ?>" /></td>
							  </tr>
					        </table>
					      </div>
					    <?php } ?>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_weekdays; ?></td>
					<td>
						<div id="languages_weekdays" class="htabs">
				            <?php foreach ($languages as $language) { ?>
				            <a href="#language_weekdays<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
				            <?php } ?>
				        </div>
				        <?php foreach ($languages as $language) { ?>
					      <div id="language_weekdays<?php echo $language['language_id']; ?>">
					        <table class="form">
					          <tr>
								<td><?php echo $entry_sunday; ?></td>
								<td><input type="text" name="ne_weekdays[<?php echo $language['language_id']; ?>][0]" size="100" value="<?php echo isset($ne_weekdays[$language['language_id']][0]) ? $ne_weekdays[$language['language_id']][0] : $entry_sunday; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_monday; ?></td>
								<td><input type="text" name="ne_weekdays[<?php echo $language['language_id']; ?>][1]" size="100" value="<?php echo isset($ne_weekdays[$language['language_id']][1]) ? $ne_weekdays[$language['language_id']][1] : $entry_monday; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_tuesday; ?></td>
								<td><input type="text" name="ne_weekdays[<?php echo $language['language_id']; ?>][2]" size="100" value="<?php echo isset($ne_weekdays[$language['language_id']][2]) ? $ne_weekdays[$language['language_id']][2] : $entry_tuesday; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_wednesday; ?></td>
								<td><input type="text" name="ne_weekdays[<?php echo $language['language_id']; ?>][3]" size="100" value="<?php echo isset($ne_weekdays[$language['language_id']][3]) ? $ne_weekdays[$language['language_id']][3] : $entry_wednesday; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_thursday; ?></td>
								<td><input type="text" name="ne_weekdays[<?php echo $language['language_id']; ?>][4]" size="100" value="<?php echo isset($ne_weekdays[$language['language_id']][4]) ? $ne_weekdays[$language['language_id']][4] : $entry_thursday; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_friday; ?></td>
								<td><input type="text" name="ne_weekdays[<?php echo $language['language_id']; ?>][5]" size="100" value="<?php echo isset($ne_weekdays[$language['language_id']][5]) ? $ne_weekdays[$language['language_id']][5] : $entry_friday; ?>" /></td>
							  </tr>
							  <tr>
								<td><?php echo $entry_saturday; ?></td>
								<td><input type="text" name="ne_weekdays[<?php echo $language['language_id']; ?>][6]" size="100" value="<?php echo isset($ne_weekdays[$language['language_id']][6]) ? $ne_weekdays[$language['language_id']][6] : $entry_saturday; ?>" /></td>
							  </tr>
					        </table>
					      </div>
					    <?php } ?>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<span style='text-align: center;'><b><?php echo $text_module_settings; ?></b></span>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_show_unloginned_subscribe; ?></td>
					<td>
						<?php if($ne_show_unloginned_subscribe == '2') {
							$checked2 = ' checked="checked"';
							$checked1 = '';
							$checked0 = '';
						} elseif($ne_show_unloginned_subscribe == '1') {
							$checked2 = '';
							$checked1 = ' checked="checked"';
							$checked0 = '';
						} else {
							$checked2 = '';
							$checked1 = '';
							$checked0 = ' checked="checked"';
						} ?>
					<label for="ne_show_unloginned_subscribe_2"><?php echo $entry_all; ?></label>
					<input type="radio"<?php echo $checked2; ?> id="ne_show_unloginned_subscribe_2" name="ne_show_unloginned_subscribe" value="2" />
					<label for="ne_show_unloginned_subscribe_1"><?php echo $entry_guests; ?></label>
					<input type="radio"<?php echo $checked1; ?> id="ne_show_unloginned_subscribe_1" name="ne_show_unloginned_subscribe" value="1" />
					<label for="ne_show_unloginned_subscribe_0"><?php echo $entry_nobody; ?></label>
					<input type="radio"<?php echo $checked0; ?> id="ne_show_unloginned_subscribe_0" name="ne_show_unloginned_subscribe" value="0" />
					</td>
				</tr>
				<tr class="module-opt">
					<td><?php echo $entry_modal_timeout; ?></td>
					<td><input type="text" name="ne_modal_timeout" value="<?php echo $ne_modal_timeout; ?>" size="3" /></td>
				</tr>
				<tr class="module-opt">
					<td><?php echo $entry_unloginned_subscribe_fields; ?></td>
					<td>
						<?php if($ne_unloginned_subscribe_fields == 1) {
							$checked0 = ' checked="checked"';
							$checked1 = '';
							$checked2 = '';
						} elseif($ne_unloginned_subscribe_fields == 2) {
							$checked0 = '';
							$checked1 = ' checked="checked"';
							$checked2 = '';
						} else {
							$checked0 = '';
							$checked1 = '';
							$checked2 = ' checked="checked"';
						} ?>
					<label for="ne_unloginned_subscribe_fields_0"><?php echo $entry_subscribe_email; ?></label>
					<input type="radio"<?php echo $checked0; ?> id="ne_unloginned_subscribe_fields_0" name="ne_unloginned_subscribe_fields" value="1" /><br/>
					<label for="ne_unloginned_subscribe_fields_1"><?php echo $entry_subscribe_email_name; ?></label>
					<input type="radio"<?php echo $checked1; ?> id="ne_unloginned_subscribe_fields_1" name="ne_unloginned_subscribe_fields" value="2" /><br/>
					<label for="ne_unloginned_subscribe_fields_2"><?php echo $entry_subscribe_email_name_lastname; ?></label>
					<input type="radio"<?php echo $checked2; ?> id="ne_unloginned_subscribe_fields_2" name="ne_unloginned_subscribe_fields" value="3" /><br/>
					</td>
				</tr>
			</table>
			<table id="module" class="list">
				<thead>
					<tr>
						<td class="left"><?php echo $entry_show_unloginned_modal; ?></td>
						<td class="left"><?php echo $entry_layout; ?></td>
						<td class="left"><?php echo $entry_position; ?></td>
						<td class="left"><?php echo $entry_status; ?></td>
						<td class="center"><?php echo $entry_sort_order; ?></td>
						<td></td>
					</tr>
				</thead>
		    	<?php $module_row = 0; ?>
		    	<?php foreach ($modules as $module) { ?>
				<tbody id="module-row<?php echo $module_row; ?>">
					<tr>
						<td class="center">
							<?php if(isset($module['is_modal']) && $module['is_modal']) {
								$checked1 = ' checked="checked"';
								$checked0 = '';
							} else {
								$checked1 = '';
								$checked0 = ' checked="checked"';
							} ?>
							<label><?php echo $entry_yes; ?>
							<input type="radio"<?php echo $checked1; ?> class="modal_check modal_check_on" name="ne_module[<?php echo $module_row; ?>][is_modal]" value="1" /></label>
							<label><?php echo $entry_no; ?>
							<input type="radio"<?php echo $checked0; ?> class="modal_check" name="ne_module[<?php echo $module_row; ?>][is_modal]" value="0" /></label>
						</td>
						<td class="left"><select name="ne_module[<?php echo $module_row; ?>][layout_id]">
						<?php foreach ($layouts as $layout) { ?>
							<?php if ($layout['layout_id'] == $module['layout_id']) { ?>
								<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
							<?php } else { ?>
								<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
							<?php } ?>
						<?php } ?>
						</select></td>
						<td class="left"><select name="ne_module[<?php echo $module_row; ?>][position]">
						<?php if ($module['position'] == 'content_top') { ?>
							<option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
						<?php } else { ?>
							<option value="content_top"><?php echo $text_content_top; ?></option>
						<?php } ?>
						<?php if ($module['position'] == 'content_bottom') { ?>
							<option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
						<?php } else { ?>
							<option value="content_bottom"><?php echo $text_content_bottom; ?></option>
						<?php } ?>
						<?php if ($module['position'] == 'column_left') { ?>
							<option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
						<?php } else { ?>
							<option value="column_left"><?php echo $text_column_left; ?></option>
						<?php } ?>
						<?php if ($module['position'] == 'column_right') { ?>
							<option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
						<?php } else { ?>
							<option value="column_right"><?php echo $text_column_right; ?></option>
						<?php } ?>
						</select></td>
						<td class="left"><select name="ne_module[<?php echo $module_row; ?>][status]">
						<?php if ($module['status']) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
						</select></td>
						<td class="center">
							<input type="text" name="ne_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" />
						</td>
						<td class="center">
							<a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a>
						</td>
					</tr>
				</tbody>
		    	<?php $module_row++; ?>
		    	<?php } ?>
				<tfoot>
					<tr>
						<td colspan="5"></td>
						<td class="center"><a onclick="addModule();" class="button"><span><?php echo $button_add_module; ?></span></a></td>
					</tr>
				</tfoot>
			</table>
			<?php } ?>
		</form>
	</div>
		<br/>
		<div style="text-align:center; color:#555555;">Newsletter Enhancements OpenCart Module</div>
</div>
<?php if (!isset($licensor)) { ?>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="center">';
	html += '    	<label><?php echo $entry_yes; ?>';
	html += '    	<input type="radio" class="modal_check modal_check_on" name="ne_module[' + module_row + '][is_modal]" value="1" /></label>';
	html += '    	<label><?php echo $entry_no; ?>';
	html += '    	<input type="radio" class="modal_check" checked="checked" name="ne_module[' + module_row + '][is_modal]" value="0" /></label>';
	html += '    </td>';
	html += '    <td class="left"><select name="ne_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="ne_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="ne_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="center"><input type="text" name="ne_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="center"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}

var list_row = [<?php echo implode(',', $list_row); ?>];

function addList(store_id) {
	html  = '<tbody id="list-row-' + store_id + '-' + list_row[store_id] + '">';
    html += '  <tr>';
	html += '    <td class="left">';
	<?php foreach ($languages as $language) { ?>
	html += '<input type="text" name="ne_marketing_list[' + store_id + '][' + list_row[store_id] + '][<?php echo $language['language_id']; ?>]" value="" /><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />';
    <?php } ?>
	html += '    </td>';
	html += '    <td class="left"><a onclick="$(\'#list-row-' + store_id + '-' + list_row[store_id] + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
    html += '  </tr>';	
    html += '</tbody>';
	
	$('#list' + store_id + ' tfoot').before(html);

	list_row[store_id] = list_row[store_id] + 1;
}

$('input[name=\'ne_throttle\']').bind('click', function() {
	checkThrottle();
});

$('input[name=\'ne_use_smtp\']').bind('click', function() {
	checkSmtp();
});

$('input[name=\'ne_bounce\']').bind('click', function() {
	checkBounce();
});

$('input[name=\'ne_show_unloginned_subscribe\']').bind('click', function() {
	checkModule();
});

$('.modal_check').live('click', function() {
	checkModal(this);
});

$('.modal_check_on').each(function(){
	checkModal(this);
});

checkThrottle();
checkSmtp();
checkBounce();
checkModule();

function checkThrottle() {
	if ($('input[name=\'ne_throttle\']:checked').val() == 1) {
		$('#throttle').show();
	} else {
		$('#throttle').hide();
	}
}

function checkSmtp() {
	if ($('input[name=\'ne_use_smtp\']:checked').val() == 1) {
		$('#smtp').show();
	} else {
		$('#smtp').hide();
	}
}

function checkBounce() {
	if ($('input[name=\'ne_bounce\']:checked').val() == 1) {
		$('#bounce').show();
	} else {
		$('#bounce').hide();
	}
}

function checkModule() {
	if ($('input[name=\'ne_show_unloginned_subscribe\']:checked').val() > 0) {
		$('#module, .module-opt').show();
	} else {
		$('#module, .module-opt').hide();
	}
}

function checkModal(obj) {
	if ($(obj).parent().parent().find('.modal_check_on').is(':checked')) {
		$(obj).parent().parent().next().next().find('select').val('content_bottom');
		$(obj).parent().parent().next().next().find('select').children('option').attr('disabled', true);
		$(obj).parent().parent().next().next().find('select').children('option[value=content_bottom]').removeAttr('disabled');
	} else {
		$(obj).parent().parent().next().next().find('select').children('option').removeAttr('disabled');
	}
}

//--></script>
<script type="text/javascript"><!--
$('#list_stores a').tabs();
$('#smtp_stores a').tabs();
$('#languages_months a').tabs(); 
$('#languages_weekdays a').tabs(); 
//--></script>
<?php } ?>
<?php echo $footer; ?>
<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------
?>
<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<?php if ($error_warning) { ?>
		<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
	<?php } ?>
	<div class="box">
		<div class="heading">
			<h1><img src="view/image/ne/marketing.png" alt="" width="22" height="22" /> <?php echo $heading_title; ?></h1>
			<div class="buttons"><a onclick="location = '<?php echo $csv; ?>';" class="button"><span><?php echo $button_csv; ?></span></a><a onclick="$('#mainform').submit();" class="button"><span><?php echo $button_delete; ?></span></a></div>
		</div>
		<div class="content">
			<?php array_unshift($stores, array('store_id' => 0, 'name' => $text_default)); ?>
			<p><?php echo $text_add_info; ?></p>
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
				<?php echo $entry_store; ?>
				<select name="store_id">
					<?php foreach ($stores as $store) { ?>
					<option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
					<?php } ?>
				</select><br/><br/>
				<textarea name="emails" style="width:99%; height:100px; padding:4px; margin-bottom:5px;"></textarea>
				<?php foreach ($stores as $store) { ?>
					<div id="list<?php echo $store['store_id']; ?>" class="list_display" style="float:left;display:none;">
						<?php if(isset($list_data[$store['store_id']]) && $list_data[$store['store_id']]) foreach ($list_data[$store['store_id']] as $key => $list) { ?>
							<label><?php echo $list[$this->config->get('config_language_id')]; ?><input name="list[<?php echo $store['store_id']; ?>][]" type="checkbox" value="<?php echo $key; ?>"/></label>&nbsp;
						<?php } ?>
					</div>
				<?php } ?>
				<a onclick="$('#form').submit();" class="button" style="float:right; margin-bottom:15px;"><span><?php echo $button_insert; ?></span></a>
			</form>
			<div style="clear:both;"></div>
			<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="mainform">
				<table class="list">
					<thead>
						<tr>
							<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
							<td class="left">
								<?php if ($sort == 'name') { ?>
								<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
								<?php } ?>
							</td>
							<td class="left">
								<?php if ($sort == 'email') { ?>
								<a href="<?php echo $sort_email; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_email; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_email; ?>"><?php echo $column_email; ?></a>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($sort == 'subscribed') { ?>
								<a href="<?php echo $sort_subscribed; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_subscribed; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_subscribed; ?>"><?php echo $column_subscribed; ?></a>
								<?php } ?>
							</td>
							<?php if ($list_data) { ?>
							<td class="right"><?php echo $column_list; ?></td>
							<?php } ?>
							<td class="right">
								<?php if ($sort == 'store_id') { ?>
								<a href="<?php echo $sort_store; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_store; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_store; ?>"><?php echo $column_store; ?></a>
								<?php } ?>
							</td>
							<td class="right"><?php echo $column_actions; ?></td>
						</tr>
					</thead>
					<tbody>
						<tr class="filter">
							<td></td>
							<td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
							<td><input type="text" name="filter_email" value="<?php echo $filter_email; ?>" /></td>
							<td class="right">
								<select name="filter_subscribed">
									<option value=""></option>
									<?php if ($filter_subscribed == '1') { ?>
									<option value="1" selected="selected"><?php echo $entry_yes; ?></option>
									<?php } else { ?>
									<option value="1"><?php echo $entry_yes; ?></option>
									<?php } ?>
									<?php if ($filter_subscribed == '0') { ?>
									<option value="0" selected="selected"><?php echo $entry_no; ?></option>
									<?php } else { ?>
									<option value="0"><?php echo $entry_no; ?></option>
									<?php } ?>
								</select>
							</td>
							<?php if ($list_data) { ?>
							<td class="right">
								<div style="height:auto;float:right;">
									<?php foreach ($stores as $store) { ?>
								      <?php if (isset($list_data[$store['store_id']])) foreach ($list_data[$store['store_id']] as $key => $list) { ?>
								      <div class="list_hide list_store<?php echo $store['store_id']; ?>" style="display:none;">
								      	<label>
								        <?php if ($filter_list && is_array($filter_list) && in_array($store['store_id'] . '_' . $key, $filter_list)) { ?>
								        <?php echo $list[$this->config->get('config_language_id')]; ?>
								        <input type="checkbox" name="filter_list[]" value="<?php echo $store['store_id']; ?>_<?php echo $key; ?>" checked="checked" />
								        <?php } else { ?>
								        <?php echo $list[$this->config->get('config_language_id')]; ?>
								        <input type="checkbox" name="filter_list[]" value="<?php echo $store['store_id']; ?>_<?php echo $key; ?>" />
								        <?php } ?>
								    	</label>
								      </div>
								      <?php } ?>
							    	<?php } ?>
							    </div>
							</td>
							<?php } ?>
							<td class="right">
								<select name="filter_store">
									<option value=""></option>
									<?php foreach ($stores as $store) { ?>
									<?php if ($filter_store == $store['store_id'] && $filter_store != '') { ?>
									<option value="<?php echo $store['store_id']; ?>" selected="selected"><?php echo $store['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
							</td>
							<td align="right">
								<a onclick="filter();" class="button"><span><?php echo $button_filter; ?></span></a>
							</td>
						</tr>
						<?php if ($marketings) { ?>
						<?php foreach ($marketings as $marketing) { ?>
						<tr>
							<td style="text-align: center;">
								<?php if ($marketing['selected']) { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $marketing['marketing_id']; ?>" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $marketing['marketing_id']; ?>" />
								<?php } ?>
							</td>
							<td class="left"><?php echo $marketing['name']; ?></td>
							<td class="left"><?php echo $marketing['email']; ?></td>
							<td class="right">
								<?php if ($marketing['subscribed'] == '1') { ?>
									<?php echo $entry_yes; ?>
								<?php } else { ?>
									<?php echo $entry_no; ?>
								<?php } ?>
							</td>
							<?php if ($list_data) { ?>
							<td class="right">
								<?php $list_out = array(); foreach ($marketing['list'] as $list_key) {
									if (isset($list_data[$marketing['store_id']][$list_key])) {
										$list_out[] = $list_data[$marketing['store_id']][$list_key][$this->config->get('config_language_id')];
									}
								}
								if ($list_out)
									echo implode(', ', $list_out); 
								?>
							</td>
							<?php } ?>
							<td class="right">
								<?php foreach ($stores as $store) { ?>
									<?php if ($marketing['store_id'] == $store['store_id']) { ?>
										<?php echo $store['name']; ?>
										<?php break; ?>
									<?php } ?>
								<?php } ?>
							</td>
							<td class="right">
								<?php if ($marketing['subscribed']) { ?>
								[ <a href="<?php echo $unsubscribe . $marketing['marketing_id'] ?>"><?php echo $button_unsubscribe; ?></a> ]
								<?php } else { ?>
								[ <a href="<?php echo $subscribe . $marketing['marketing_id'] ?>"><?php echo $button_subscribe; ?></a> ]
								<?php } ?>
							</td>
						</tr>
						<?php } ?>
						<?php } else { ?>
						<tr>
							<td class="center" colspan="<?php echo ($list_data ? 7 : 6); ?>"><?php echo $text_no_results; ?></td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
			</form>
			<div class="pagination"><?php echo $pagination; ?></div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=ne/marketing&token=<?php echo $token; ?>';

	var filter_name = $('input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_email = $('input[name=\'filter_email\']').attr('value');
	
	if (filter_email) {
		url += '&filter_email=' + encodeURIComponent(filter_email);
	}

	var filter_subscribed = $('select[name=\'filter_subscribed\']').attr('value');
	
	if (filter_subscribed) {
		url += '&filter_subscribed=' + encodeURIComponent(filter_subscribed);
	}

	var filter_list = [];

	$.each($('input[name=\'filter_list[]\']:checked'), function() {
		filter_list.push($(this).val());
	});
		
	if (filter_list.length) {
		url += '&filter_list=' + encodeURIComponent(filter_list.join());
	}

	var filter_store = $('select[name=\'filter_store\']').attr('value');
	
	if (filter_store) {
		url += '&filter_store=' + encodeURIComponent(filter_store);
	}
	
	location = url;
}
//--></script>
<script type="text/javascript"><!--
$('#list' + $('select[name=\'store_id\']').attr('value')).show();

$('select[name=\'store_id\']').change(function(){
	$('.list_display').hide();
	$('#list' + $(this).attr('value')).show();
});

if ($('select[name=\'filter_store\']').attr('value') != '') {
	$('.list_store' + $('select[name=\'filter_store\']').attr('value')).show();
} else {
	$('.list_hide').show();
}

$('select[name=\'filter_store\']').change(function(){
	$('.list_hide').hide();
	if ($(this).attr('value') != '') {
		$('.list_store' + $(this).attr('value')).show();
	} else {
		$('.list_hide').show();
	}
});

$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});
//--></script>
<?php echo $footer; ?>
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
			<h1><img src="view/image/ne/subscribers.png" alt="" width="22" height="22" /> <?php echo $heading_title; ?></h1>
		</div>
		<div class="content">
			<table class="list">
				<thead>
					<tr>
						<td class="left">
							<?php if ($sort == 'name') { ?>
							<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
							<?php } else { ?>
							<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
							<?php } ?>
						</td>
						<td class="left">
							<?php if ($sort == 'c.email') { ?>
							<a href="<?php echo $sort_email; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_email; ?></a>
							<?php } else { ?>
							<a href="<?php echo $sort_email; ?>"><?php echo $column_email; ?></a>
							<?php } ?>
						</td>
						<td class="right">
							<?php if ($sort == 'customer_group') { ?>
							<a href="<?php echo $sort_customer_group; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_customer_group; ?></a>
							<?php } else { ?>
							<a href="<?php echo $sort_customer_group; ?>"><?php echo $column_customer_group; ?></a>
							<?php } ?>
						</td>
						<td class="right">
							<?php if ($sort == 'c.newsletter') { ?>
							<a href="<?php echo $sort_newsletter; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_newsletter; ?></a>
							<?php } else { ?>
							<a href="<?php echo $sort_newsletter; ?>"><?php echo $column_newsletter; ?></a>
							<?php } ?>
						</td>
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
						<td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
						<td><input type="text" name="filter_email" value="<?php echo $filter_email; ?>" /></td>
						<td class="right"><select name="filter_customer_group_id">
			              <option value=""></option>
			              <?php foreach ($customer_groups as $customer_group) { ?>
			              <?php if ($customer_group['customer_group_id'] == $filter_customer_group_id) { ?>
			              <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
			              <?php } else { ?>
			              <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
			              <?php } ?>
			              <?php } ?>
			            </select></td>
						<td class="right">
							<select name="filter_newsletter">
								<option value=""></option>
								<?php if ($filter_newsletter == '1') { ?>
								<option value="1" selected="selected"><?php echo $entry_yes; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $entry_yes; ?></option>
								<?php } ?>
								<?php if ($filter_newsletter == '0') { ?>
								<option value="0" selected="selected"><?php echo $entry_no; ?></option>
								<?php } else { ?>
								<option value="0"><?php echo $entry_no; ?></option>
								<?php } ?>
							</select>
						</td>
						<td class="right">
							<select name="filter_store">
								<option value=""></option>
								<?php if ($filter_store == '0') { ?>
								<option value="0" selected="selected"><?php echo $text_default; ?></option>
								<?php } else { ?>
								<option value="0"><?php echo $text_default; ?></option>
								<?php } ?>
								<?php foreach ($stores as $store) { ?>
								<?php if ($filter_store == $store['store_id']) { ?>
								<option value="<?php echo $store['store_id']; ?>" selected="selected"><?php echo $store['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
								<?php } ?>
								<?php } ?>
							</select>
						</td>
						<td class="right"><a onclick="filter();" class="button"><span><?php echo $button_filter; ?></span></a></td>
					</tr>
					<?php if ($customers) { ?>
					<?php foreach ($customers as $customer) { ?>
					<tr>
						<td class="left"><?php echo $customer['name']; ?></td>
						<td class="left"><?php echo $customer['email']; ?></td>
						<td class="right"><?php echo $customer['customer_group']; ?></td>
						<td class="right">
							<?php if ($customer['newsletter'] == '1') { ?>
								<?php echo $entry_yes; ?>
							<?php } else { ?>
								<?php echo $entry_no; ?>
							<?php } ?>
						</td>
						<td class="right">
							<?php if ($customer['store_id'] == '0') { ?>
								<?php echo $text_default; ?>
							<?php } else { ?>
								<?php foreach ($stores as $store) { ?>
									<?php if ($customer['store_id'] == $store['store_id']) { ?>
										<?php echo $store['name']; ?>
										<?php break; ?>
									<?php } ?>
								<?php } ?>
							<?php } ?>
						</td>
						<td class="right">
							<?php if ($customer['newsletter']) { ?>
							[ <a href="<?php echo $unsubscribe . $customer['customer_id'] ?>"><?php echo $button_unsubscribe; ?></a> ]
							<?php } else { ?>
							[ <a href="<?php echo $subscribe . $customer['customer_id'] ?>"><?php echo $button_subscribe; ?></a> ]
							<?php } ?>
						</td>
					</tr>
					<?php } ?>
					<?php } else { ?>
					<tr>
						<td class="center" colspan="6"><?php echo $text_no_results; ?></td>
					</tr>
					<?php } ?>
				</tbody>
			</table>
			<div class="pagination"><?php echo $pagination; ?></div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=ne/subscribers&token=<?php echo $token; ?>';
	
	var filter_name = $('input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}
	
	var filter_email = $('input[name=\'filter_email\']').attr('value');
	
	if (filter_email) {
		url += '&filter_email=' + encodeURIComponent(filter_email);
	}

	var filter_customer_group_id = $('select[name=\'filter_customer_group_id\']').attr('value');
	
	if (filter_customer_group_id) {
		url += '&filter_customer_group_id=' + encodeURIComponent(filter_customer_group_id);
	}	

	var filter_newsletter = $('select[name=\'filter_newsletter\']').attr('value');

	if (filter_newsletter) {
		url += '&filter_newsletter=' + encodeURIComponent(filter_newsletter);
	}

	var filter_store = $('select[name=\'filter_store\']').attr('value');
	
	if (filter_store) {
		url += '&filter_store=' + encodeURIComponent(filter_store);
	}
	
	location = url;
}
//--></script>
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});
//--></script>
<?php echo $footer; ?>
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
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td style="width:200px;"><?php echo $entry_status; ?></td>
            <td style="width: 200px;"><select name="quickcheckout_status">
                <?php if ($quickcheckout_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td style="width:200px;"><?php echo $entry_newsletter; ?></td>
              <td><select name="quickcheckout_newsletter">
                <?php if ($quickcheckout_newsletter) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
			<td><?php echo $entry_survey; ?></td>
			<td><select name="quickcheckout_survey">
                <?php if ($quickcheckout_survey) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            <td><?php echo $entry_company; ?></td>
			<td><select name="quickcheckout_company">
                <?php if ($quickcheckout_company) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_address_2; ?></td>
			<td><select name="quickcheckout_address_2">
                <?php if ($quickcheckout_address_2) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td><?php echo $entry_fax; ?></td>
			<td><select name="quickcheckout_fax">
                <?php if ($quickcheckout_fax) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_city; ?></td>
			<td><select name="quickcheckout_city">
                <?php if ($quickcheckout_city) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			 <td><?php echo $entry_postcode; ?></td>
			<td><select name="quickcheckout_postcode">
                <?php if ($quickcheckout_postcode) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_country; ?></td>
			<td><select name="quickcheckout_country">
                <?php if ($quickcheckout_country) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			<td><?php echo $entry_zone; ?></td>
			<td><select name="quickcheckout_zone">
                <?php if ($quickcheckout_zone) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_shipping; ?></td>
			<td><select name="quickcheckout_shipping">
                <?php if ($quickcheckout_shipping) { ?>
                <option value="1" selected="selected"><?php echo $text_radio; ?></option>
                <option value="0"><?php echo $text_select; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_radio; ?></option>
                <option value="0" selected="selected"><?php echo $text_select; ?></option>
                <?php } ?>
              </select></td>
			<td><?php echo $entry_payment; ?></td>
			<td><select name="quickcheckout_payment">
                <?php if ($quickcheckout_payment) { ?>
                <option value="1" selected="selected"><?php echo $text_radio; ?></option>
                <option value="0"><?php echo $text_select; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_radio; ?></option>
                <option value="0" selected="selected"><?php echo $text_select; ?></option>
                <?php } ?>
              </select></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<div style="text-align:center; color:#222222;">Quick Checkout v4.1 by <a target="_blank" href="http://www.marketinsg.com/">MarketInSG</a><br>Donate to <a href="http://www.marketinsg.com/donate" target="_blank">MarketInSG</a></div>
<?php echo $footer; ?>
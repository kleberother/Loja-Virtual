<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------
?>
<?php if ($tracks) { ?>
  	<table class="ne_stats_recipient_track">
  		<thead>
  			<tr>
    		<th><?php echo $entry_url; ?></th>
    		<th><?php echo $entry_clicks; ?></th>
    	</tr>
  		</thead>
  	  	<tbody>
  	  		<?php foreach ($tracks as $entry) { ?>
  	  		<tr>
						<td><a href="<?php echo $entry['url']; ?>" target="_blank"><?php echo $entry['url']; ?></a></td>
						<td><?php echo $entry['clicks']; ?></td>
					</tr>
					<?php } ?>
  	  	</tbody>
     </table>
<?php } else { ?>
    <p style="text-align:center;"><?php echo $text_no_data ?></p>
<?php } ?>
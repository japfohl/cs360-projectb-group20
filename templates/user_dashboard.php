<div class="container">
    <div class="row">
        <div class="eight columns offset-by-two">
            <h1 id="welcome" class="centered-text">Welcome - <?php echo "$fname $lname"; ?></h1>
        </div>
    </div>
    <p class="centered-text">
        <em>Selecting a value will increase an item's values-based price depending on how a given company scores
        in that category.</em>
    </p>
    <h4 class="centered-text"><strong>Your Values:</strong></h4>
    <table class="u-full-width">
        
        <?php if (empty($uservals)): ?>
            <p>No Values Selected!</p>
        <?php else: ?>
            <?php foreach( $uservals as $val ): ?>
                <tr>
                    <td class="no-bottom-border">
                        <p class="value-name"><?php echo $val["vname"]; ?></p>
                    </td>
                    <td class="no-bottom-border">
                        <a href="remove_value.php?user_id=<?php echo $user_id; ?>&val_id=<?php echo $val["val_id"]; ?>" class="button remove-button u-max-full-width u-pull-right">
                            Remove
                        </a>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p><?php echo $val["vcopy"]; ?></p>
                    </td>
                </tr>
            <?php endforeach; ?>
        <?php endif; ?>
        
    </table>
    
    <h4 class="centered-text"><strong>Unselected Values:</strong></h4>
    <table class="u-full-width">
        <?php if (empty($non_uservals)): ?>
            <p>All Values Selected!</p>
        <?php else: ?>
            <?php foreach( $non_uservals as $val ): ?>
                <tr>
                    <td class="no-bottom-border">
                        <p class="value-name"><?php echo $val["vname"]; ?></p>
                    </td>
                    <td class="no-bottom-border">
                        <a href="add_value.php?user_id=<?php echo $user_id; ?>&val_id=<?php echo $val["val_id"]; ?>" class="button add-button u-max-full-width u-pull-right">
                            Add
                        </a>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p><?php echo $val["vcopy"]; ?></p>
                    </td>
                </tr>
            <?php endforeach; ?>
        <?php endif; ?>
    </table>
</div>

</body>
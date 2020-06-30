<div id="page">
    <header id=header" role="banner">
        <form:form method="post" action="logout" name="logout" autocomplete="on">
            <table width="100%" style="background: #d0ffd0; color: #006600; border-radius: 10px;">
                <tbody>
                <tr>
                    <td width="40px" style="text-align:left;">
                        <img src="${logo}" alt="" class="popup_logo" height="40px"/>
                    </td>
                    <td style="text-align:center; font-size:25px">
                    </td>
                    <td style="text-align:right;">
                            ${webUser.getUserName()} (${webUser.getFullUserName()})
                    </td>
                    <td width="30px" style="text-align:right;">
                        <button class="button_exit">
                            <input type="image" src="${exit}" alt="" class="popup_logo" height="30px"/>
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
        </form:form>
    </header>
</div>

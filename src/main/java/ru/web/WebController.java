package ru.web;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.ui.ModelMap;
//import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.google.common.collect.ImmutableMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@ControllerAdvice
@Scope("session")
//@CacheEvict(value = {"login", "params"}, allEntries = true)
//@SessionAttributes(value = "login")
//@SessionAttributes(types = WebController.class)
public class WebController {

    // внедряем значение из application.properties
    @Value("${project.name:test}")
    private String PROJECT_NAME;

    @Value("${project.version:1.0}")
    private String PROJECT_VERSION;

    private final String FILE_PROPERTIES = "spring-boot.properties";

    private static final Logger LOG = LogManager.getLogger();

    private WebUser webUser = new WebUser();
    private WebParams webParams = new WebParams();
    private List<String> themesList = new ArrayList<>();

    private boolean isOk;
    private String session;

    public WebController() {
        for (int i = 0; i < 10; i++) {
            themesList.add("Тест " + i);
        }
    }

    @RequestMapping(value = {"/", "/login", "/logout", "/params", "/desktop", "/result"}, method = RequestMethod.GET)
    private ModelAndView showLoginGet() {
        return createModel("login");
    }

    @RequestMapping(value = {"/", "/login", "/logout"}, method = RequestMethod.POST)
    private ModelAndView showLoginPost() {
        return createModel("login");
    }

    @RequestMapping(value = "/params", method = RequestMethod.POST)
    private ModelAndView createParamsPost(@ModelAttribute("webParams") WebParams webParams,
                                          HttpServletRequest request,
                                          HttpServletResponse response) throws MessagingException {
        ModelAndView mav;
        isOk = true;
        String errorMessage = "";
        if (webParams.getUserName() != null && !webParams.getUserName().isEmpty()) {
            webUser.setUserName(webParams.getUserName());
            webUser.setPassword(webParams.getPassword());
            if (webParams.getFullUserName() != null && !webParams.getFullUserName().isEmpty()) {
                webUser.setFullUserName((webParams.getFullUserName()));
            }
        } else {
            webUser.clear();
        }

        mav = createModel("params",
                ImmutableMap.<String, Object>builder()
                        .put("themesList", themesList)
                        .build());
        return mav;
    }

    @RequestMapping(value = "/desktop", method = RequestMethod.POST)
    private ModelAndView createDesktop(@ModelAttribute("webParams") WebParams webParams,
                                       HttpServletRequest request,
                                       HttpServletResponse response) throws MessagingException {
        ModelAndView mav = null;
        String errorMessage = "";
/*
        if (!userAuthorizationService.isSessionCorrect()){
            errorMessage = "Сессия просрочена";
            mav = createModel("login", webParams, Optional.of(errorMessage));
        }
*/

        if (errorMessage.isEmpty() && (webParams.getTheme() == null || webParams.getTheme().isEmpty())) {
            errorMessage = "Выберите тему для тестирования";
            mav = createModel("params",
                    ImmutableMap.<String, Object>builder()
                            .put("themesList", themesList)
                            .build(),
                    Optional.of(errorMessage));
        }

        if (errorMessage.isEmpty()) {
// выводим отчет
            mav = createModel("desktop", ImmutableMap.<String, Object>builder()
                    .put("result", "")
                    .put("questions", "")
                    .build());
        }

        return mav;
    }

    @RequestMapping(value = "/result", method = RequestMethod.POST)
    private ModelAndView createResult(@ModelAttribute("webParams") WebParams webParams,
                                      HttpServletRequest request,
                                      HttpServletResponse response) throws MessagingException {

//        LOG.info("{} {}", webUser.getUserName(), webParams.getTheme());
        this.webParams.setTheme(webParams.getTheme());

        ModelAndView mav;
        String errorMessage = "";
        StringBuilder res = new StringBuilder("\r\n");

/*
        if (!userAuthorizationService.isSessionCorrect()){
            errorMessage = "Сессия просрочена";
        }
*/

//        mav = createModel("desktop", ImmutableMap.<String, Object>builder()
        mav = createModel("result",
                ImmutableMap.<String, Object>builder()
                        .put("result", "Ну что, нормальный реультат.")
//                .put("questions", null)//questions)
                        .build());

        return mav;
    }



    private ModelAndView createModel(String viewName) {
        return createModel(viewName, webParams, Optional.empty());
    }

    private ModelAndView createModel(String viewName, WebParams webParams) {
        return createModel(viewName, webParams, Optional.empty());
    }

    private ModelAndView createModel(String viewName, WebParams webParams, Optional<String> errorMessage) {
        ImmutableMap.Builder<String, Object> builder = ImmutableMap.builder();
        if (errorMessage.isPresent()) {
            builder = builder.put("errorMessage", errorMessage.get());
//            LOG.error("Есть ошибка {}", errorMessage.getString());
        }
//        return createModel(viewName, builder.put(WebParamsObject.NAME, webParams).build());
//        LOG.info("createModel(viewName = {} )", viewName);
        return createModel(viewName, builder.put("login", webParams).build());
    }

    private ModelAndView createModel(String viewName, Map<String, Object> attribute) {
        return createModel(viewName, attribute, null);
    }

    private ModelAndView createModel(String viewName,
                                     Map<String, Object> attribute,
                                     Optional<String> errorMessage) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName(viewName);
        attribute.forEach((t, u) -> mav.addObject(t, u));
        mav.addObject("PROJECT_NAME", PROJECT_NAME);
        mav.addObject("PROJECT_VERSION", PROJECT_VERSION);
        mav.addObject("webUser", webUser);
        mav.addObject("webParams", webParams);
        if (errorMessage != null && errorMessage.isPresent()) {
            mav.addObject("errorMessage", errorMessage.get());
        }
        return mav;
    }

/*
    @ModelAttribute
    public void addAttributes(Model model) {
        model.addAttribute("PROJECT_NAME", PROJECT_NAME);
        model.addAttribute("PROJECT_VERSION", PROJECT_VERSION);
    }
*/
}

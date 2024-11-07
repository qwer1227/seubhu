package store.seub2hu2.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @GetMapping("/home")
    public String home() {

        return "admin/home";
    }

    @GetMapping("/course")
    public String course() {

        return "admin/course";
    }

    @GetMapping("/user")
    public String user() {

        return "admin/user";
    }

    @GetMapping("/product")
    public String product() {

        return "admin/product";
    }

    @GetMapping("/stock")
    public String stock() {

        return "admin/stock";
    }

    @GetMapping("/community")
    public String community() {

        return "admin/community";
    }
}

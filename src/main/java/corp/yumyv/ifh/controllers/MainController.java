package corp.yumyv.ifh.controllers;

import corp.yumyv.ifh.entities.Role;
import corp.yumyv.ifh.entities.User;
import corp.yumyv.ifh.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Collections;

@Controller
@RequiredArgsConstructor
public class MainController {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;


    private void addDefaultAdmin(){
        User adminFromDb = userRepository.findByName("admin");
        if (adminFromDb == null) {
            User admin = new User();
            admin.setName("admin");
            admin.setActive(true);
            admin.setRoles(Collections.singleton(Role.ADMIN));
            admin.setPass(passwordEncoder.encode("admin"));
            userRepository.save(admin);
        }
    }

    @GetMapping("/")
    public String main(Model model) {
        this.addDefaultAdmin();
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth.getName().equals("anonymousUser")) {
            model.addAttribute("isActive", false);
            return "main";
        } else {
            model.addAttribute("isActive", true);
            return "main";
        }
    }
}

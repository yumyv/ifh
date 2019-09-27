package corp.yumyv.ifh.controllers;

import corp.yumyv.ifh.entities.Role;
import corp.yumyv.ifh.entities.User;
import corp.yumyv.ifh.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Collections;

@Controller
@RequiredArgsConstructor
public class RegistrationController {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String add(User user, Model model) {
        User userFromDb = userRepository.findByName(user.getName());
        if (userFromDb != null) {
            model.addAttribute("message", "User exists!");
            return "registration";
        } else if ((user.getName().length() > 0) && (user.getPass().length() > 0)) {
            user.setActive(true);
            user.setRoles(Collections.singleton(Role.USER));
            user.setPass(passwordEncoder.encode(user.getPass()));
            userRepository.save(user);
            return "redirect:/login";
        } else {
            model.addAttribute("message", "Invalid input!");
            return "registration";
        }
    }
}

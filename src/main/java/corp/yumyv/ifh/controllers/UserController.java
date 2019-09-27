package corp.yumyv.ifh.controllers;

import corp.yumyv.ifh.entities.*;
import corp.yumyv.ifh.repositories.*;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.Principal;
import java.util.Calendar;
import java.util.Collection;

@Controller
@RequiredArgsConstructor
public class UserController {
    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final WalletRepository walletRepository;
    private final CategoryRepository categoryRepository;
    private final RecordRepository recordRepository;
    private final OperationRepository operationRepository;

    private static final String INCOME_FOR_NAME_COLUMN_IN_RECORD_TABLE = "income";
    private static final String EXPENSE_FOR_NAME_COLUMN_IN_RECORD_TABLE = "expense";
    private static final String TRANSFER_FOR_NAME_COLUMN_IN_RECORD_TABLE = "transfer";

    private void addDefaultValuesToRecordTable() {
        if (recordRepository.findByName(INCOME_FOR_NAME_COLUMN_IN_RECORD_TABLE) == null) {
            Record incomeRecord = new Record();
            incomeRecord.setName(INCOME_FOR_NAME_COLUMN_IN_RECORD_TABLE);
            recordRepository.save(incomeRecord);
        }
        if (recordRepository.findByName(EXPENSE_FOR_NAME_COLUMN_IN_RECORD_TABLE) == null) {
            Record expenseRecord = new Record();
            expenseRecord.setName(EXPENSE_FOR_NAME_COLUMN_IN_RECORD_TABLE);
            recordRepository.save(expenseRecord);
        }
        if (recordRepository.findByName(TRANSFER_FOR_NAME_COLUMN_IN_RECORD_TABLE) == null) {
            Record transferRecord = new Record();
            transferRecord.setName(TRANSFER_FOR_NAME_COLUMN_IN_RECORD_TABLE);
            recordRepository.save(transferRecord);
        }
    }

    private void updateWalletValueAfterRecord(Long recordId, Long walletId, BigDecimal value) {
        Wallet walletToUpdate = walletRepository.getOne(walletId);
        if (recordRepository.getOne(recordId).getName().equals(INCOME_FOR_NAME_COLUMN_IN_RECORD_TABLE)) {
            BigDecimal newValue = value.add(walletToUpdate.getValue());
            walletToUpdate.setValue(newValue.setScale(2, RoundingMode.HALF_EVEN));
            walletRepository.save(walletToUpdate);
        } else if (recordRepository.getOne(recordId).getName().equals(EXPENSE_FOR_NAME_COLUMN_IN_RECORD_TABLE)) {
            BigDecimal newValue = walletToUpdate.getValue().subtract(value);
            walletToUpdate.setValue(newValue.setScale(2, RoundingMode.HALF_EVEN));
            walletRepository.save(walletToUpdate);
        }
    }

    private void updateWalletValueAfterTransfer(Long recordId, Long fromWalletId, Long toWalletId, BigDecimal value) {
        if (!fromWalletId.equals(toWalletId)) {
            Wallet fromWalletToUpdate = walletRepository.getOne(fromWalletId);
            Wallet toWalletToUpdate = walletRepository.getOne(toWalletId);
            if (recordRepository.getOne(recordId).getName().equals(TRANSFER_FOR_NAME_COLUMN_IN_RECORD_TABLE)) {
                BigDecimal newValueForFromWallet = fromWalletToUpdate.getValue().subtract(value);
                BigDecimal newValueForToWallet = toWalletToUpdate.getValue().add(value);
                fromWalletToUpdate.setValue(newValueForFromWallet.setScale(2, RoundingMode.HALF_EVEN));
                toWalletToUpdate.setValue(newValueForToWallet.setScale(2, RoundingMode.HALF_EVEN));
                walletRepository.save(fromWalletToUpdate);
                walletRepository.save(toWalletToUpdate);
            }
        }

    }

    @GetMapping("/user")
    public String user(Model model, Principal principal) {
        this.addDefaultValuesToRecordTable();
        String userName = principal.getName();
        Long userId = userRepository.findByName(principal.getName()).getId();

        model.addAttribute("userName", userName);
        model.addAttribute("wallets", walletRepository.findByUserIdOrderByName(userId));
        model.addAttribute("categories", categoryRepository.findByUserIdOrderByName(userId));
        model.addAttribute("operations", operationRepository.findByUserIdOrderByIdDesc(userId));
        model.addAttribute("lastOperations", operationRepository.findFirst20ByUserIdOrderByIdDesc(userId));
        model.addAttribute("records", recordRepository.findAll());
        return "user";
    }

    @PostMapping("/user/update")
    public String userUpdate(User user, Principal principal) {
        User userToUpdate = userRepository.getOne(userRepository.findByName(principal.getName()).getId());
        userToUpdate.setPass(passwordEncoder.encode(user.getPass()));
        userRepository.save(userToUpdate);
        return "redirect:/login";
    }

    @PostMapping("/user/wallet/add")
    public String walletAdd(@AuthenticationPrincipal User user, Wallet wallet) {
        wallet.setValue(wallet.getValue().setScale(2, RoundingMode.HALF_EVEN));
        wallet.setUser(user);
        walletRepository.save(wallet);
        return "redirect:/user";
    }

    @PostMapping("/user/wallet/update")
    public String walletUpdate(Wallet wallet) {
        if (wallet.getId() != null) {
            Wallet walletToUpdate = walletRepository.getOne(wallet.getId());
            walletToUpdate.setName(wallet.getName());
            walletRepository.save(walletToUpdate);
            return "redirect:/user";
        } else {
            return "redirect:/user";
        }
    }

    @PostMapping("/user/wallet/delete")
    public String walletDelete(Wallet wallet) {
        if (wallet.getId() != null) {
            walletRepository.deleteById(wallet.getId());
            return "redirect:/user";
        } else {
            return "redirect:/user";
        }
    }

    @PostMapping("/user/category/add")
    public String categoryAdd(@AuthenticationPrincipal User user, Category category) {
        category.setUser(user);
        categoryRepository.save(category);
        return "redirect:/user";
    }

    @PostMapping("/user/category/update")
    public String categoryUpdate(Category category) {
        if (category.getId() != null) {
            Category categoryToUpdate = categoryRepository.getOne(category.getId());
            categoryToUpdate.setName(category.getName());
            categoryRepository.save(categoryToUpdate);
            return "redirect:/user";
        } else {
            return "redirect:/user";
        }
    }

    @PostMapping("/user/category/delete")
    public String categoryDelete(Category category) {
        if (category.getId() != null) {
            categoryRepository.deleteById(category.getId());
            return "redirect:/user";
        } else {
            return "redirect:/user";
        }
    }

    @PostMapping("/user/operation/add")
    public String operationAdd(
            @AuthenticationPrincipal User user,
            @RequestParam String walletId,
            @RequestParam String categoryId,
            @RequestParam String recordId,
            Operation operation
    ) {
        operation.setValue(operation.getValue().setScale(2, RoundingMode.HALF_EVEN));
        operation.setUser(user);
        operation.setDate(Calendar.getInstance().getTime());
        operation.setCategory(categoryRepository.getOne(Long.parseLong(categoryId)).getName());
        operation.setRecord(recordRepository.getOne(Long.parseLong(recordId)).getName());
        operation.setWallet(walletRepository.getOne(Long.parseLong(walletId)).getName());

        this.updateWalletValueAfterRecord(
                Long.parseLong(recordId), Long.parseLong(walletId), operation.getValue()
        );

        operationRepository.save(operation);
        return "redirect:/user";
    }

    @PostMapping("/user/operation/transfer")
    public String operationTransfer(
            @AuthenticationPrincipal User user,
            @RequestParam String fromWalletId,
            @RequestParam String toWalletId,
            @RequestParam String recordId,
            Operation operation
    ) {
        operation.setValue(operation.getValue().setScale(2, RoundingMode.HALF_EVEN));
        operation.setUser(user);
        operation.setDate(Calendar.getInstance().getTime());
        operation.setCategory("transfer");
        operation.setRecord(recordRepository.getOne(Long.parseLong(recordId)).getName());
        operation.setWallet(walletRepository.getOne(Long.parseLong(fromWalletId)).getName());

        this.updateWalletValueAfterTransfer(
                Long.parseLong(recordId), Long.parseLong(fromWalletId), Long.parseLong(toWalletId),
                operation.getValue()
        );

        operationRepository.save(operation);
        return "redirect:/user";
    }

    @GetMapping("/user/operation/delete")
    public String operationDelete(Principal principal) {
        Collection<Operation> operations = operationRepository.findByUserIdOrderByIdDesc(
                userRepository.findByName(principal.getName()).getId()
        );
        operations.forEach((o) -> operationRepository.deleteById(o.getId()));
        return "redirect:/user";
    }
}
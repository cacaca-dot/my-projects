package com.example.mydataapp;

import android.os.Bundle;

import android.content.Intent;
import android.content.SharedPreferences;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    EditText etUser, etPass;
    Button btnLogin, btnCancel;
    SharedPreferences sharedPref;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etUser = findViewById(R.id.etUsername);
        etPass = findViewById(R.id.etPassword);
        btnLogin = findViewById(R.id.btnLogin);
        btnCancel = findViewById(R.id.btnCancel);
        sharedPref = getSharedPreferences("UserSession", MODE_PRIVATE);

        btnLogin.setOnClickListener(v -> {

            String username = etUser.getText().toString().trim();
            String password = etPass.getText().toString().trim();

            if (username.isEmpty() || password.isEmpty()) {

                Toast.makeText(
                        MainActivity.this,
                        "Lengkapi semua data terlebih dahulu",
                        Toast.LENGTH_SHORT).show();

            }

            else if (username.equals("admin")
                    && password.equals("admin123")) {

                SharedPreferences sp =
                        getSharedPreferences("DATA", MODE_PRIVATE);

                SharedPreferences.Editor editor = sp.edit();

                editor.putString("username", username);

                editor.apply();

                Intent intent = new Intent(
                        MainActivity.this,
                        DashboardActivity.class);

                startActivity(intent);

            }

            else {

                Toast.makeText(
                        MainActivity.this,
                        "Username atau Password salah",
                        Toast.LENGTH_SHORT).show();
            }
        });
        btnCancel.setOnClickListener(v -> {
            etUser.setText("");
            etPass.setText(""); // [cite: 12]
        });
    }
}
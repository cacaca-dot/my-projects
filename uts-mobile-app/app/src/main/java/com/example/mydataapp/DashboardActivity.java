package com.example.mydataapp;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;

public class DashboardActivity extends AppCompatActivity {

    TextView txtWelcome;

    EditText etNim, etNama, etProdi,
            etKelas, etAlamat, etEmail;

    Button btnTambah, btnLogout;

    ListView listView;

    ArrayList<StudentData> dataList;

    StudentAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dashboard);

        txtWelcome = findViewById(R.id.txtWelcome);

        etNim = findViewById(R.id.etNim);
        etNama = findViewById(R.id.etNama);
        etProdi = findViewById(R.id.etProdi);
        etKelas = findViewById(R.id.etKelas);
        etAlamat = findViewById(R.id.etAlamat);
        etEmail = findViewById(R.id.etEmail);

        btnTambah = findViewById(R.id.btnTambah);
        btnLogout = findViewById(R.id.btnLogout);

        listView = findViewById(R.id.listView);

        SharedPreferences sp = getSharedPreferences("DATA", MODE_PRIVATE);

        String username = sp.getString("username", "");

        txtWelcome.setText("Selamat Datang " + username);

        dataList = new ArrayList<>();

        adapter = new StudentAdapter(
                this,
                dataList
        );

        listView.setAdapter(adapter);

        btnTambah.setOnClickListener(v -> {

            String nim = etNim.getText().toString().trim();
            String nama = etNama.getText().toString().trim();
            String prodi = etProdi.getText().toString().trim();
            String kelas = etKelas.getText().toString().trim();
            String alamat = etAlamat.getText().toString().trim();
            String email = etEmail.getText().toString().trim();

            // Validasi field kosong
            if (nim.isEmpty() ||
                    nama.isEmpty() ||
                    prodi.isEmpty() ||
                    kelas.isEmpty() ||
                    alamat.isEmpty() ||
                    email.isEmpty()) {

                Toast.makeText(
                        DashboardActivity.this,
                        "Lengkapi semua data terlebih dahulu",
                        Toast.LENGTH_SHORT).show();

            } else {
                StudentData student = new StudentData(
                        nim,
                        nama,
                        prodi,
                        kelas,
                        alamat,
                        email
                );

                dataList.add(student);
                adapter.notifyDataSetChanged();
                Toast.makeText(
                        DashboardActivity.this,
                        "Data berhasil ditambahkan",
                        Toast.LENGTH_SHORT).show();

                etNim.setText("");
                etNama.setText("");
                etProdi.setText("");
                etKelas.setText("");
                etAlamat.setText("");
                etEmail.setText("");

                etNim.requestFocus();
            }
        });

        btnLogout.setOnClickListener(v -> {

            Intent intent = new Intent(
                    DashboardActivity.this,
                    MainActivity.class);

            startActivity(intent);

            finish();
        });
    }


}
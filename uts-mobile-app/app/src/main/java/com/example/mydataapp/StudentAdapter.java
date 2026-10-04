package com.example.mydataapp;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.List;

public class StudentAdapter extends ArrayAdapter<StudentData> {

    public StudentAdapter(@NonNull Context context,
                          @NonNull List<StudentData> objects) {
        super(context, 0, objects);
    }

    @NonNull
    @Override
    public View getView(int position,
                        @Nullable View convertView,
                        @NonNull ViewGroup parent) {

        if (convertView == null) {
            convertView = LayoutInflater.from(getContext())
                    .inflate(R.layout.item_student, parent, false);
        }

        StudentData student = getItem(position);

        TextView tvNama = convertView.findViewById(R.id.tvNama);
        TextView tvNim = convertView.findViewById(R.id.tvNim);
        TextView tvInfo = convertView.findViewById(R.id.tvInfo);
        TextView tvAlamat = convertView.findViewById(R.id.tvAlamat);
        TextView tvEmail = convertView.findViewById(R.id.tvEmail);

        if (student != null) {

            tvNama.setText(student.getNama());

            tvNim.setText(
                    "NIM : "
                            + student.getNim());

            tvInfo.setText(
                    student.getProdi()
                            + " | "
                            + student.getKelas());

            tvAlamat.setText(
                    "Alamat : "
                            + student.getAlamat());

            tvEmail.setText(
                    "Email : "
                            + student.getEmail());
        }

        return convertView;
    }
}

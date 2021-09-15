//
//  MemoTableCell.swift
//  VoiceMemo
//
//  Created by John Hatvani on 15/9/21.
//

import Foundation

protocol MemoTableCell {
    func configure(withRecord: Recordable);
}
